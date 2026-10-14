import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ScoreEndpoint extends Endpoint {
  static const String _omrUrl =
      String.fromEnvironment('OMR_URL', defaultValue: 'http://localhost:8001');

  // ---------------------------------------------------------------------------
  // UPLOAD
  // ---------------------------------------------------------------------------
  Future<Score> upload(
    Session session, {
    required String fileName,
    required String fileType,
    required String fileBase64,
    String? title,
    String locale = 'en',
  }) async {
    const allowed = ['image/png', 'image/jpeg', 'image/jpg', 'application/pdf'];
    if (!allowed.contains(fileType)) {
      throw Exception('Unsupported file type: $fileType');
    }

    final bytes = base64Decode(fileBase64);
    if (bytes.length > 20 * 1024 * 1024) {
      throw Exception('File too large (max 20 MB)');
    }

    // 1. Call OMR first
    final omr = await _callOmr(
      session,
      bytes: bytes,
      fileName: fileName,
      locale: locale,
    );

    // 2. Build imageUrl: oemer teaser if available, otherwise original image
    final imageUrl = omr.teaserB64.isNotEmpty
        ? 'data:image/png;base64,${omr.teaserB64}'
        : 'data:$fileType;base64,$fileBase64';

    // 3. Persist
    final now = DateTime.now().toUtc();
    final score = Score(
      title: (title == null || title.trim().isEmpty)
          ? _titleFromFileName(fileName)
          : title.trim(),
      fileName: fileName,
      fileType: fileType,
      storagePath: '',
      imageUrl: imageUrl,
      engine: omr.engine,
      confidence: omr.confidence,
      rawMusicXml: omr.musicXml,
      notes: omr.notes,
      isPublic: true,
      createdAt: now,
      updatedAt: now,
    );

    return Score.db.insertRow(session, score);
  }

  // ---------------------------------------------------------------------------
  // LIST
  // ---------------------------------------------------------------------------
  Future<ScoreListResult> list(
    Session session, {
    String? query,
    int page = 1,
    int pageSize = 12,
  }) async {
    final safePage = page < 1 ? 1 : page;
    final safeSize = pageSize.clamp(1, 50);
    final offset = (safePage - 1) * safeSize;
    final trimmed = (query ?? '').trim();

    List<Score> items;
    int total;

    if (trimmed.isEmpty) {
      items = await Score.db.find(
        session,
        where: (t) => t.isPublic.equals(true),
        limit: safeSize,
        offset: offset,
      );
      total = await Score.db.count(
        session,
        where: (t) => t.isPublic.equals(true),
      );
    } else {
      items = await Score.db.find(
        session,
        where: (t) => t.isPublic.equals(true) & t.title.like('%$trimmed%'),
        limit: safeSize,
        offset: offset,
      );
      total = await Score.db.count(
        session,
        where: (t) => t.isPublic.equals(true) & t.title.like('%$trimmed%'),
      );
    }

    return ScoreListResult(items: items, total: total);
  }

  // ---------------------------------------------------------------------------
  // GET BY ID
  // ---------------------------------------------------------------------------
  Future<Score?> getById(Session session, int id) async {
    return Score.db.findById(session, id);
  }

  // ---------------------------------------------------------------------------
  // DELETE ONE
  // ---------------------------------------------------------------------------
  Future<bool> delete(Session session, int id) async {
    final score = await Score.db.findById(session, id);
    if (score == null) return false;
    await Score.db.deleteRow(session, score);
    return true;
  }

  // ---------------------------------------------------------------------------
  // DELETE ALL (cleanup — dangerous in production)
  // ---------------------------------------------------------------------------
  Future<int> deleteAll(Session session) async {
    final all = await Score.db.find(session);
    for (final s in all) {
      await Score.db.deleteRow(session, s);
    }
    return all.length;
  }

  // ---------------------------------------------------------------------------
  // HELPERS
  // ---------------------------------------------------------------------------
  Future<_OmrResult> _callOmr(
    Session session, {
    required List<int> bytes,
    required String fileName,
    required String locale,
  }) async {
    try {
      final req = http.MultipartRequest('POST', Uri.parse('$_omrUrl/process'))
        ..fields['locale'] = locale
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: fileName,
        ));

      final streamed = await req.send().timeout(const Duration(seconds: 900));
      final response = await http.Response.fromStream(streamed);

      if (response.statusCode != 200) {
        throw Exception('OMR ${response.statusCode}: ${response.body}');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final rawNotes = (json['notes'] as List).cast<Map<String, dynamic>>();

      final notes = rawNotes.map((n) {
        return DetectedNote(
          noteId: (n['id'] as String?) ?? 'n-${n.hashCode}',
          type: (n['type'] as String?) ?? 'note',
          pitch: n['pitch'] as String?,
          octave: n['octave'] as int?,
          accidental: n['accidental'] as String?,
          x: (n['x'] as num).toDouble(),
          y: (n['y'] as num).toDouble(),
          measure: ((n['measure'] as num?) ?? 1).toInt(),
          staff: (n['staff'] as String?) ?? 'treble',
        );
      }).toList();

      return _OmrResult(
        engine: (json['engine'] as String?) ?? 'unknown',
        confidence: (json['confidence'] as num?)?.toDouble(),
        musicXml: json['musicxml'] as String?,
        notes: notes,
        teaserB64: (json['teaser_png_base64'] as String?) ?? '',
      );
    } catch (e) {
      session.log('OMR call failed: $e', level: LogLevel.error);
      return _OmrResult(
        engine: 'error',
        confidence: 0.0,
        musicXml: null,
        notes: <DetectedNote>[],
        teaserB64: '',
      );
    }
  }

  String _titleFromFileName(String name) {
    final dot = name.lastIndexOf('.');
    final base = dot > 0 ? name.substring(0, dot) : name;
    return base.replaceAll('_', ' ').replaceAll('-', ' ');
  }
}

// -----------------------------------------------------------------------------
// RESULT WRAPPER (internal)
// -----------------------------------------------------------------------------
class _OmrResult {
  final String engine;
  final double? confidence;
  final String? musicXml;
  final List<DetectedNote> notes;
  final String teaserB64;

  _OmrResult({
    required this.engine,
    required this.confidence,
    required this.musicXml,
    required this.notes,
    required this.teaserB64,
  });
}