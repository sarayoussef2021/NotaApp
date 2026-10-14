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
import 'package:backend_server/src/generated/protocol.dart' as _ij04tvhs;
import 'package:serverpod/serverpod.dart' as _is;
import 'detected_note.dart' as _ig1j31ny;

abstract class Score implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      notes: _ij04tvhs.Protocol().deserialize<List<_ig1j31ny.DetectedNote>>(
          jsonSerialization['notes']),
      isPublic: _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      ownerId: jsonSerialization['ownerId'] as int?,
      createdAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _is.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ScoreTable();

  static const db = ScoreRepository._();

  @override
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

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Score]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
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

  static ScoreInclude include() {
    return ScoreInclude._();
  }

  static ScoreIncludeList includeList({
    _is.WhereExpressionBuilder<ScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    ScoreInclude? include,
  }) {
    return ScoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
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

class ScoreUpdateTable extends _is.UpdateTable<ScoreTable> {
  ScoreUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
        table.title,
        value,
      );

  _is.ColumnValue<String, String> composer(String? value) => _is.ColumnValue(
        table.composer,
        value,
      );

  _is.ColumnValue<String, String> arrangedBy(String? value) => _is.ColumnValue(
        table.arrangedBy,
        value,
      );

  _is.ColumnValue<String, String> fileName(String value) => _is.ColumnValue(
        table.fileName,
        value,
      );

  _is.ColumnValue<String, String> fileType(String value) => _is.ColumnValue(
        table.fileType,
        value,
      );

  _is.ColumnValue<String, String> storagePath(String value) => _is.ColumnValue(
        table.storagePath,
        value,
      );

  _is.ColumnValue<String, String> imageUrl(String value) => _is.ColumnValue(
        table.imageUrl,
        value,
      );

  _is.ColumnValue<String, String> engine(String value) => _is.ColumnValue(
        table.engine,
        value,
      );

  _is.ColumnValue<double, double> confidence(double? value) => _is.ColumnValue(
        table.confidence,
        value,
      );

  _is.ColumnValue<String, String> rawMusicXml(String? value) => _is.ColumnValue(
        table.rawMusicXml,
        value,
      );

  _is.ColumnValue<List<_ig1j31ny.DetectedNote>, List<_ig1j31ny.DetectedNote>>
      notes(List<_ig1j31ny.DetectedNote> value) => _is.ColumnValue(
            table.notes,
            value,
          );

  _is.ColumnValue<bool, bool> isPublic(bool value) => _is.ColumnValue(
        table.isPublic,
        value,
      );

  _is.ColumnValue<int, int> ownerId(int? value) => _is.ColumnValue(
        table.ownerId,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _is.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ScoreTable extends _is.Table<int?> {
  ScoreTable({super.tableRelation}) : super(tableName: 'score') {
    updateTable = ScoreUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    composer = _is.ColumnString(
      'composer',
      this,
    );
    arrangedBy = _is.ColumnString(
      'arrangedBy',
      this,
    );
    fileName = _is.ColumnString(
      'fileName',
      this,
    );
    fileType = _is.ColumnString(
      'fileType',
      this,
    );
    storagePath = _is.ColumnString(
      'storagePath',
      this,
    );
    imageUrl = _is.ColumnString(
      'imageUrl',
      this,
    );
    engine = _is.ColumnString(
      'engine',
      this,
    );
    confidence = _is.ColumnDouble(
      'confidence',
      this,
    );
    rawMusicXml = _is.ColumnString(
      'rawMusicXml',
      this,
    );
    notes = _is.ColumnSerializable<List<_ig1j31ny.DetectedNote>>(
      'notes',
      this,
    );
    isPublic = _is.ColumnBool(
      'isPublic',
      this,
    );
    ownerId = _is.ColumnInt(
      'ownerId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _is.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ScoreUpdateTable updateTable;

  late final _is.ColumnString title;

  late final _is.ColumnString composer;

  late final _is.ColumnString arrangedBy;

  late final _is.ColumnString fileName;

  late final _is.ColumnString fileType;

  late final _is.ColumnString storagePath;

  late final _is.ColumnString imageUrl;

  late final _is.ColumnString engine;

  late final _is.ColumnDouble confidence;

  late final _is.ColumnString rawMusicXml;

  late final _is.ColumnSerializable<List<_ig1j31ny.DetectedNote>> notes;

  late final _is.ColumnBool isPublic;

  late final _is.ColumnInt ownerId;

  late final _is.ColumnDateTime createdAt;

  late final _is.ColumnDateTime updatedAt;

  @override
  List<_is.Column> get columns => [
        id,
        title,
        composer,
        arrangedBy,
        fileName,
        fileType,
        storagePath,
        imageUrl,
        engine,
        confidence,
        rawMusicXml,
        notes,
        isPublic,
        ownerId,
        createdAt,
        updatedAt,
      ];
}

class ScoreInclude extends _is.IncludeObject {
  ScoreInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Score.t;
}

class ScoreIncludeList extends _is.IncludeList {
  ScoreIncludeList._({
    _is.WhereExpressionBuilder<ScoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Score.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Score.t;
}

class ScoreRepository {
  const ScoreRepository._();

  /// Returns a list of [Score]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Score>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Score>(
      where: where?.call(Score.t),
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Score] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Score?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreTable>? where,
    int? offset,
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Score>(
      where: where?.call(Score.t),
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Score] by its [id] or null if no such row exists.
  Future<Score?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Score>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Score]s in the list and returns the inserted rows.
  ///
  /// The returned [Score]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> insert(
    _is.DatabaseSession session,
    List<Score> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Score>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Score] and returns the inserted row.
  ///
  /// The returned [Score] will have its `id` field set.
  Future<Score> insertRow(
    _is.DatabaseSession session,
    Score row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Score>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Score]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Score]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> upsert(
    _is.DatabaseSession session,
    List<Score> rows, {
    required _is.ColumnSelections<ScoreTable> conflictColumns,
    _is.ColumnSelections<ScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<ScoreTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Score>(
      rows,
      conflictColumns: conflictColumns(Score.t),
      updateColumns: updateColumns?.call(Score.t),
      updateWhere: updateWhere?.call(Score.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Score] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Score] will have its `id` field set.
  Future<Score?> upsertRow(
    _is.DatabaseSession session,
    Score row, {
    required _is.ColumnSelections<ScoreTable> conflictColumns,
    _is.ColumnSelections<ScoreTable>? updateColumns,
    _is.WhereExpressionBuilder<ScoreTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Score>(
      row,
      conflictColumns: conflictColumns(Score.t),
      updateColumns: updateColumns?.call(Score.t),
      updateWhere: updateWhere?.call(Score.t),
      transaction: transaction,
    );
  }

  /// Updates all [Score]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> update(
    _is.DatabaseSession session,
    List<Score> rows, {
    _is.ColumnSelections<ScoreTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Score>(
      rows,
      columns: columns?.call(Score.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Score]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Score> updateRow(
    _is.DatabaseSession session,
    Score row, {
    _is.ColumnSelections<ScoreTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Score>(
      row,
      columns: columns?.call(Score.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Score] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Score?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ScoreUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Score>(
      id,
      columnValues: columnValues(Score.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Score]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ScoreUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ScoreTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Score>(
      columnValues: columnValues(Score.t.updateTable),
      where: where(Score.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Score]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> delete(
    _is.DatabaseSession session,
    List<Score> rows, {
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Score>(
      rows,
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Score].
  Future<Score> deleteRow(
    _is.DatabaseSession session,
    Score row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Score>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Score>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScoreTable> where,
    _is.OrderByBuilder<ScoreTable>? orderBy,
    _is.OrderByListBuilder<ScoreTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Score>(
      where: where(Score.t),
      orderBy: orderBy?.call(Score.t),
      orderByList: orderByList?.call(Score.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ScoreTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Score>(
      where: where?.call(Score.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Score] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ScoreTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Score>(
      where: where(Score.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
