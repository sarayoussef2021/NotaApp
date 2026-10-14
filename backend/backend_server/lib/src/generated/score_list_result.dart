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
import 'score.dart' as _iznxlmy5;

abstract class ScoreListResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ScoreListResult._({
    required this.items,
    required this.total,
  });

  factory ScoreListResult({
    required List<_iznxlmy5.Score> items,
    required int total,
  }) = _ScoreListResultImpl;

  factory ScoreListResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScoreListResult(
      items: _ij04tvhs.Protocol()
          .deserialize<List<_iznxlmy5.Score>>(jsonSerialization['items']),
      total: jsonSerialization['total'] as int,
    );
  }

  List<_iznxlmy5.Score> items;

  int total;

  /// Returns a shallow copy of this [ScoreListResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ScoreListResult copyWith({
    List<_iznxlmy5.Score>? items,
    int? total,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScoreListResult',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'total': total,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScoreListResult',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'total': total,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _ScoreListResultImpl extends ScoreListResult {
  _ScoreListResultImpl({
    required List<_iznxlmy5.Score> items,
    required int total,
  }) : super._(
          items: items,
          total: total,
        );

  /// Returns a shallow copy of this [ScoreListResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ScoreListResult copyWith({
    List<_iznxlmy5.Score>? items,
    int? total,
  }) {
    return ScoreListResult(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      total: total ?? this.total,
    );
  }
}
