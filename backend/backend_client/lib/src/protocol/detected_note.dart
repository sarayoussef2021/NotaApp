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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class DetectedNote
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DetectedNote._({
    required this.noteId,
    required this.type,
    this.pitch,
    this.octave,
    this.accidental,
    required this.x,
    required this.y,
    required this.measure,
    required this.staff,
  });

  factory DetectedNote({
    required String noteId,
    required String type,
    String? pitch,
    int? octave,
    String? accidental,
    required double x,
    required double y,
    required int measure,
    required String staff,
  }) = _DetectedNoteImpl;

  factory DetectedNote.fromJson(Map<String, dynamic> jsonSerialization) {
    return DetectedNote(
      noteId: jsonSerialization['noteId'] as String,
      type: jsonSerialization['type'] as String,
      pitch: jsonSerialization['pitch'] as String?,
      octave: jsonSerialization['octave'] as int?,
      accidental: jsonSerialization['accidental'] as String?,
      x: (jsonSerialization['x'] as num).toDouble(),
      y: (jsonSerialization['y'] as num).toDouble(),
      measure: jsonSerialization['measure'] as int,
      staff: jsonSerialization['staff'] as String,
    );
  }

  String noteId;

  String type;

  String? pitch;

  int? octave;

  String? accidental;

  double x;

  double y;

  int measure;

  String staff;

  /// Returns a shallow copy of this [DetectedNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DetectedNote copyWith({
    String? noteId,
    String? type,
    String? pitch,
    int? octave,
    String? accidental,
    double? x,
    double? y,
    int? measure,
    String? staff,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DetectedNote',
      'noteId': noteId,
      'type': type,
      if (pitch != null) 'pitch': pitch,
      if (octave != null) 'octave': octave,
      if (accidental != null) 'accidental': accidental,
      'x': x,
      'y': y,
      'measure': measure,
      'staff': staff,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DetectedNote',
      'noteId': noteId,
      'type': type,
      if (pitch != null) 'pitch': pitch,
      if (octave != null) 'octave': octave,
      if (accidental != null) 'accidental': accidental,
      'x': x,
      'y': y,
      'measure': measure,
      'staff': staff,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DetectedNoteImpl extends DetectedNote {
  _DetectedNoteImpl({
    required String noteId,
    required String type,
    String? pitch,
    int? octave,
    String? accidental,
    required double x,
    required double y,
    required int measure,
    required String staff,
  }) : super._(
          noteId: noteId,
          type: type,
          pitch: pitch,
          octave: octave,
          accidental: accidental,
          x: x,
          y: y,
          measure: measure,
          staff: staff,
        );

  /// Returns a shallow copy of this [DetectedNote]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DetectedNote copyWith({
    String? noteId,
    String? type,
    Object? pitch = _Undefined,
    Object? octave = _Undefined,
    Object? accidental = _Undefined,
    double? x,
    double? y,
    int? measure,
    String? staff,
  }) {
    return DetectedNote(
      noteId: noteId ?? this.noteId,
      type: type ?? this.type,
      pitch: pitch is String? ? pitch : this.pitch,
      octave: octave is int? ? octave : this.octave,
      accidental: accidental is String? ? accidental : this.accidental,
      x: x ?? this.x,
      y: y ?? this.y,
      measure: measure ?? this.measure,
      staff: staff ?? this.staff,
    );
  }
}
