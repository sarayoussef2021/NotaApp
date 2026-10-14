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
import 'dart:async' as _ida;
import 'package:backend_client/src/protocol/score.dart' as _i2gvrhxp;
import 'package:backend_client/src/protocol/score_list_result.dart'
    as _id6bh4jn;
import 'package:http/http.dart' as _i85jenna;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// {@category Endpoint}
class EndpointContact extends _isc.EndpointRef {
  EndpointContact(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'contact';

  _ida.Future<bool> send({
    required String name,
    required String email,
    required String message,
    required String locale,
  }) =>
      caller.callServerEndpoint<bool>(
        'contact',
        'send',
        {
          'name': name,
          'email': email,
          'message': message,
          'locale': locale,
        },
      );
}

/// {@category Endpoint}
class EndpointScore extends _isc.EndpointRef {
  EndpointScore(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'score';

  _ida.Future<_i2gvrhxp.Score> upload({
    required String fileName,
    required String fileType,
    required String fileBase64,
    String? title,
    required String locale,
  }) =>
      caller.callServerEndpoint<_i2gvrhxp.Score>(
        'score',
        'upload',
        {
          'fileName': fileName,
          'fileType': fileType,
          'fileBase64': fileBase64,
          'title': title,
          'locale': locale,
        },
      );

  _ida.Future<_id6bh4jn.ScoreListResult> list({
    String? query,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<_id6bh4jn.ScoreListResult>(
        'score',
        'list',
        {
          'query': query,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _ida.Future<_i2gvrhxp.Score?> getById(int id) =>
      caller.callServerEndpoint<_i2gvrhxp.Score?>(
        'score',
        'getById',
        {'id': id},
      );

  _ida.Future<bool> delete(int id) => caller.callServerEndpoint<bool>(
        'score',
        'delete',
        {'id': id},
      );

  _ida.Future<int> deleteAll() => caller.callServerEndpoint<int>(
        'score',
        'deleteAll',
        {},
      );
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
          host,
          _il2as5qe.Protocol(),
          securityContext: securityContext,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
          httpClientOverride: httpClientOverride,
        ) {
    contact = EndpointContact(this);
    score = EndpointScore(this);
  }

  late final EndpointContact contact;

  late final EndpointScore score;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
        'contact': contact,
        'score': score,
      };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {};
}
