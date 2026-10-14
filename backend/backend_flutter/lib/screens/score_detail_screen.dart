import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:backend_client/backend_client.dart';

class ScoreDetailScreen extends StatelessWidget {
  final Score score;

  const ScoreDetailScreen({super.key, required this.score});

  Uint8List? _decodeImage() {
    final url = score.imageUrl;
    if (url.isEmpty) return null;
    // Handles: data:image/png;base64,XXXX
    final commaIdx = url.indexOf(',');
    if (url.startsWith('data:') && commaIdx != -1) {
      final b64 = url.substring(commaIdx + 1);
      try {
        return base64Decode(b64);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  String _noteLabel(DetectedNote n) {
    if (n.pitch == null || n.pitch!.isEmpty) return '—';
    final acc = n.accidental ?? '';
    return '${n.pitch}$acc';
  }

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeImage();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          score.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        children: [
          // Score image
          if (bytes != null)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Image.memory(bytes, fit: BoxFit.contain),
            )
          else
            const Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No image available',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

          const SizedBox(height: 8),

          // Metadata card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _row('Engine', score.engine.toUpperCase()),
                    _row('Confidence',
                        score.confidence?.toStringAsFixed(2) ?? '—'),
                    _row('Notes', '${score.notes.length}'),
                    _row('Measures',
                        _countMeasures().toString()),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Notes list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'DETECTED NOTES (${score.notes.length})',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
                letterSpacing: 0.8,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ..._buildMeasureRows(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  int _countMeasures() {
    final set = <int>{};
    for (final n in score.notes) {
      set.add(n.measure);
    }
    return set.length;
  }

  List<Widget> _buildMeasureRows() {
    final map = <int, List<DetectedNote>>{};
    for (final n in score.notes) {
      map.putIfAbsent(n.measure, () => []).add(n);
    }
    final keys = map.keys.toList()..sort();
    return keys.map((m) {
      final notes = map[m]!;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 40,
              child: Text(
                'M$m',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF94A3B8),
                ),
              ),
            ),
            Expanded(
              child: Wrap(
                spacing: 5,
                runSpacing: 5,
                children: notes.map((n) {
                  final isBass = n.staff == 'bass';
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isBass
                          ? const Color(0xFFFAF5FF)
                          : Colors.white,
                      border: Border.all(
                        color: isBass
                            ? const Color(0xFFE9D5FF)
                            : const Color(0xFFE5E7EB),
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _noteLabel(n),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isBass
                            ? const Color(0xFF9333EA)
                            : const Color(0xFF2563EB),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}