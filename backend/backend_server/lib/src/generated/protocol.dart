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
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'contact_message.dart' as _itkhxrdg;
import 'detected_note.dart' as _ig1j31ny;
import 'score.dart' as _iznxlmy5;
import 'score_list_result.dart' as _i28ucdw1;
export 'contact_message.dart';
export 'detected_note.dart';
export 'score.dart';
export 'score_list_result.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
        _isp.TableDefinition(
          name: 'contact_message',
          dartName: 'ContactMessage',
          schema: 'public',
          module: 'backend',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'name',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'email',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'message',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'locale',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'handled',
              columnType: _isp.ColumnType.boolean,
              isNullable: false,
              dartType: 'bool',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
          ],
          foreignKeys: [],
          indexes: [],
          managed: true,
        ),
        _isp.TableDefinition(
          name: 'score',
          dartName: 'Score',
          schema: 'public',
          module: 'backend',
          columns: [
            _isp.ColumnDefinition(
              name: 'id',
              columnType: _isp.ColumnType.bigint,
              isNullable: false,
              dartType: 'int?',
              columnDefault: 'serial',
            ),
            _isp.ColumnDefinition(
              name: 'title',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'composer',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'arrangedBy',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'fileName',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'fileType',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'storagePath',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'imageUrl',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'engine',
              columnType: _isp.ColumnType.text,
              isNullable: false,
              dartType: 'String',
            ),
            _isp.ColumnDefinition(
              name: 'confidence',
              columnType: _isp.ColumnType.doublePrecision,
              isNullable: true,
              dartType: 'double?',
            ),
            _isp.ColumnDefinition(
              name: 'rawMusicXml',
              columnType: _isp.ColumnType.text,
              isNullable: true,
              dartType: 'String?',
            ),
            _isp.ColumnDefinition(
              name: 'notes',
              columnType: _isp.ColumnType.json,
              isNullable: false,
              dartType: 'List<protocol:DetectedNote>',
            ),
            _isp.ColumnDefinition(
              name: 'isPublic',
              columnType: _isp.ColumnType.boolean,
              isNullable: false,
              dartType: 'bool',
            ),
            _isp.ColumnDefinition(
              name: 'ownerId',
              columnType: _isp.ColumnType.bigint,
              isNullable: true,
              dartType: 'int?',
            ),
            _isp.ColumnDefinition(
              name: 'createdAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
            _isp.ColumnDefinition(
              name: 'updatedAt',
              columnType: _isp.ColumnType.timestampWithoutTimeZone,
              isNullable: false,
              dartType: 'DateTime',
            ),
          ],
          foreignKeys: [],
          indexes: [
            _isp.IndexDefinition(
              indexName: 'score_title_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'title',
                )
              ],
              type: 'btree',
              isUnique: false,
              isPrimary: false,
            ),
            _isp.IndexDefinition(
              indexName: 'score_created_idx',
              tableSpace: null,
              elements: [
                _isp.IndexElementDefinition(
                  type: _isp.IndexElementDefinitionType.column,
                  definition: 'createdAt',
                )
              ],
              type: 'btree',
              isUnique: false,
              isPrimary: false,
            ),
          ],
          managed: true,
        ),
        ..._isp.Protocol.targetTableDefinitions,
      ];

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
      } on _is.DeserializationClassNameNotFoundException catch (_) {
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
    if (t == _is.getType<_itkhxrdg.ContactMessage?>()) {
      return (data != null ? _itkhxrdg.ContactMessage.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ig1j31ny.DetectedNote?>()) {
      return (data != null ? _ig1j31ny.DetectedNote.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iznxlmy5.Score?>()) {
      return (data != null ? _iznxlmy5.Score.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i28ucdw1.ScoreListResult?>()) {
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
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
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
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
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
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _itkhxrdg.ContactMessage:
        return _itkhxrdg.ContactMessage.t;
      case _iznxlmy5.Score:
        return _iznxlmy5.Score.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

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
    try {
      return _isp.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
