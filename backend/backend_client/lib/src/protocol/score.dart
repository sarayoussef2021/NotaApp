/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:backend_client/src/protocol/protocol.dart' as _i4cn93tr;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'detected_note.dart' as _ig1j31ny;

abstract class Score
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Score._({
    this.id,
    required this.title,
    this.composer,
    this.arrangedBy,
    required this.fileName,
    required this.fileType,
    required this.storagePath,
    required this.imageUrl,
    required this.engine,
    this.confidence,
    this.rawMusicXml,
    required this.notes,
    required this.isPublic,
    this.ownerId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Score({
    int? id,
    required String title,
    String? composer,
    String? arrangedBy,
    required String fileName,
    required String fileType,
    required String storagePath,
    required String imageUrl,
    required String engine,
    double? confidence,
    String? rawMusicXml,
    required List<_ig1j31ny.DetectedNote> notes,
    required bool isPublic,
    int? ownerId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScoreImpl;

  factory Score.fromJson(Map<String, dynamic> jsonSerialization) {
    return Score(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      composer: jsonSerialization['composer'] as String?,
      arrangedBy: jsonSerialization['arrangedBy'] as String?,
      fileName: jsonSerialization['fileName'] as String,
      fileType: jsonSerialization['fileType'] as String,
      storagePath: jsonSerialization['storagePath'] as String,
      imageUrl: jsonSerialization['imageUrl'] as String,
      engine: jsonSerialization['engine'] as String,
      confidence: (jsonSerialization['confidence'] as num?)?.toDouble(),
      rawMusicXml: jsonSerialization['rawMusicXml'] as String?,
      notes: _i4cn93tr.Protocol().deserialize<List<_ig1j31ny.DetectedNote>>(
          jsonSerialization['notes']),
      isPublic: _isc.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      ownerId: jsonSerialization['ownerId'] as int?,
      createdAt:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String? composer;

  String? arrangedBy;

  String fileName;

  String fileType;

  String storagePath;

  String imageUrl;

  String engine;

  double? confidence;

  String? rawMusicXml;

  List<_ig1j31ny.DetectedNote> notes;

  bool isPublic;

  int? ownerId;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Score]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Score copyWith({
    int? id,
    String? title,
    String? composer,
    String? arrangedBy,
    String? fileName,
    String? fileType,
    String? storagePath,
    String? imageUrl,
    String? engine,
    double? confidence,
    String? rawMusicXml,
    List<_ig1j31ny.DetectedNote>? notes,
    bool? isPublic,
    int? ownerId,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Score',
      if (id != null) 'id': id,
      'title': title,
      if (composer != null) 'composer': composer,
      if (arrangedBy != null) 'arrangedBy': arrangedBy,
      'fileName': fileName,
      'fileType': fileType,
      'storagePath': storagePath,
      'imageUrl': imageUrl,
      'engine': engine,
      if (confidence != null) 'confidence': confidence,
      if (rawMusicXml != null) 'rawMusicXml': rawMusicXml,
      'notes': notes.toJson(valueToJson: (v) => v.toJson()),
      'isPublic': isPublic,
      if (ownerId != null) 'ownerId': ownerId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Score',
      if (id != null) 'id': id,
      'title': title,
      if (composer != null) 'composer': composer,
      if (arrangedBy != null) 'arrangedBy': arrangedBy,
      'fileName': fileName,
      'fileType': fileType,
      'storagePath': storagePath,
      'imageUrl': imageUrl,
      'engine': engine,
      if (confidence != null) 'confidence': confidence,
      if (rawMusicXml != null) 'rawMusicXml': rawMusicXml,
      'notes': notes.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'isPublic': isPublic,
      if (ownerId != null) 'ownerId': ownerId,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScoreImpl extends Score {
  _ScoreImpl({
    int? id,
    required String title,
    String? composer,
    String? arrangedBy,
    required String fileName,
    required String fileType,
    required String storagePath,
    required String imageUrl,
    required String engine,
    double? confidence,
    String? rawMusicXml,
    required List<_ig1j31ny.DetectedNote> notes,
    required bool isPublic,
    int? ownerId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          title: title,
          composer: composer,
          arrangedBy: arrangedBy,
          fileName: fileName,
          fileType: fileType,
          storagePath: storagePath,
          imageUrl: imageUrl,
          engine: engine,
          confidence: confidence,
          rawMusicXml: rawMusicXml,
          notes: notes,
          isPublic: isPublic,
          ownerId: ownerId,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Score]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Score copyWith({
    Object? id = _Undefined,
    String? title,
    Object? composer = _Undefined,
    Object? arrangedBy = _Undefined,
    String? fileName,
    String? fileType,
    String? storagePath,
    String? imageUrl,
    String? engine,
    Object? confidence = _Undefined,
    Object? rawMusicXml = _Undefined,
    List<_ig1j31ny.DetectedNote>? notes,
    bool? isPublic,
    Object? ownerId = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Score(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      composer: composer is String? ? composer : this.composer,
      arrangedBy: arrangedBy is String? ? arrangedBy : this.arrangedBy,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      storagePath: storagePath ?? this.storagePath,
      imageUrl: imageUrl ?? this.imageUrl,
      engine: engine ?? this.engine,
      confidence: confidence is double? ? confidence : this.confidence,
      rawMusicXml: rawMusicXml is String? ? rawMusicXml : this.rawMusicXml,
      notes: notes ?? this.notes.map((e0) => e0.copyWith()).toList(),
      isPublic: isPublic ?? this.isPublic,
      ownerId: ownerId is int? ? ownerId : this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
