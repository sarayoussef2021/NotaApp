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
import 'package:backend_server/src/generated/future_calls.dart' as _i1ykytn3;
import 'package:serverpod/serverpod.dart' as _is;
import '../endpoints/contact_endpoint.dart' as _iioqm6zp;
import '../endpoints/score_endpoint.dart' as _iboa5om2;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'contact': _iioqm6zp.ContactEndpoint()
        ..initialize(
          server,
          'contact',
          null,
        ),
      'score': _iboa5om2.ScoreEndpoint()
        ..initialize(
          server,
          'score',
          null,
        ),
    };
    connectors['contact'] = _is.EndpointConnector(
      name: 'contact',
      endpoint: endpoints['contact']!,
      methodConnectors: {
        'send': _is.MethodConnector(
          name: 'send',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'message': _is.ParameterDescription(
              name: 'message',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['contact'] as _iioqm6zp.ContactEndpoint).send(
            session,
            name: params['name'],
            email: params['email'],
            message: params['message'],
            locale: params['locale'],
          ),
        )
      },
    );
    connectors['score'] = _is.EndpointConnector(
      name: 'score',
      endpoint: endpoints['score']!,
      methodConnectors: {
        'upload': _is.MethodConnector(
          name: 'upload',
          params: {
            'fileName': _is.ParameterDescription(
              name: 'fileName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileType': _is.ParameterDescription(
              name: 'fileType',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'fileBase64': _is.ParameterDescription(
              name: 'fileBase64',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'locale': _is.ParameterDescription(
              name: 'locale',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['score'] as _iboa5om2.ScoreEndpoint).upload(
            session,
            fileName: params['fileName'],
            fileType: params['fileType'],
            fileBase64: params['fileBase64'],
            title: params['title'],
            locale: params['locale'],
          ),
        ),
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'query': _is.ParameterDescription(
              name: 'query',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'page': _is.ParameterDescription(
              name: 'page',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'pageSize': _is.ParameterDescription(
              name: 'pageSize',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['score'] as _iboa5om2.ScoreEndpoint).list(
            session,
            query: params['query'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getById': _is.MethodConnector(
          name: 'getById',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['score'] as _iboa5om2.ScoreEndpoint).getById(
            session,
            params['id'],
          ),
        ),
        'delete': _is.MethodConnector(
          name: 'delete',
          params: {
            'id': _is.ParameterDescription(
              name: 'id',
              type: _is.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['score'] as _iboa5om2.ScoreEndpoint).delete(
            session,
            params['id'],
          ),
        ),
        'deleteAll': _is.MethodConnector(
          name: 'deleteAll',
          params: {},
          call: (
            _is.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['score'] as _iboa5om2.ScoreEndpoint)
                  .deleteAll(session),
        ),
      },
    );
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _i1ykytn3.FutureCalls();
  }
}
