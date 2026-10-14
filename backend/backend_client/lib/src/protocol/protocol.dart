/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'contact_message.dart' as _itkhxrdg;
import 'detected_note.dart' as _ig1j31ny;
import 'score.dart' as _iznxlmy5;
import 'score_list_result.dart' as _i28ucdw1;
export 'contact_message.dart';
export 'detected_note.dart';
export 'score.dart';
export 'score_list_result.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _itkhxrdg.ContactMessage) {
      return _itkhxrdg.ContactMessage.fromJson(data) as T;
    }
    if (t == _ig1j31ny.DetectedNote) {
      return _ig1j31ny.DetectedNote.fromJson(data) as T;
    }
    if (t == _iznxlmy5.Score) {
      return _iznxlmy5.Score.fromJson(data) as T;
    }
    if (t == _i28ucdw1.ScoreListResult) {
      return _i28ucdw1.ScoreListResult.fromJson(data) as T;
    }
    if (t == _isc.getType<_itkhxrdg.ContactMessage?>()) {
      return (data != null ? _itkhxrdg.ContactMessage.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ig1j31ny.DetectedNote?>()) {
      return (data != null ? _ig1j31ny.DetectedNote.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iznxlmy5.Score?>()) {
      return (data != null ? _iznxlmy5.Score.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i28ucdw1.ScoreListResult?>()) {
      return (data != null ? _i28ucdw1.ScoreListResult.fromJson(data) : null)
          as T;
    }
    if (t == List<_ig1j31ny.DetectedNote>) {
      return (data as List)
          .map((e) => deserialize<_ig1j31ny.DetectedNote>(e))
          .toList() as T;
    }
    if (t == List<_iznxlmy5.Score>) {
      return (data as List).map((e) => deserialize<_iznxlmy5.Score>(e)).toList()
          as T;
    }
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _itkhxrdg.ContactMessage => 'ContactMessage',
      _ig1j31ny.DetectedNote => 'DetectedNote',
      _iznxlmy5.Score => 'Score',
      _i28ucdw1.ScoreListResult => 'ScoreListResult',
      _ => null
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('backend.', '');
    }

    switch (data) {
      case _itkhxrdg.ContactMessage():
        return 'ContactMessage';
      case _ig1j31ny.DetectedNote():
        return 'DetectedNote';
      case _iznxlmy5.Score():
        return 'Score';
      case _i28ucdw1.ScoreListResult():
        return 'ScoreListResult';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ContactMessage') {
      return deserialize<_itkhxrdg.ContactMessage>(data['data']);
    }
    if (dataClassName == 'DetectedNote') {
      return deserialize<_ig1j31ny.DetectedNote>(data['data']);
    }
    if (dataClassName == 'Score') {
      return deserialize<_iznxlmy5.Score>(data['data']);
    }
    if (dataClassName == 'ScoreListResult') {
      return deserialize<_i28ucdw1.ScoreListResult>(data['data']);
    }
    return super.deserializeByClassName(data);
  }

  @override
  String getModuleName() => 'backend';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
