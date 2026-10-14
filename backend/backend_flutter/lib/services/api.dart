import 'package:backend_client/backend_client.dart';

/// Singleton API client pointing to the local Serverpod backend.
/// On Android emulator, use 10.0.2.2 instead of localhost.
class Api {
  Api._();
  static final Api instance = Api._();

  late final Client client;

  String get _host {
    // Default: localhost (works on iOS simulator, web, desktop).
    // Android emulator needs 10.0.2.2 to reach the host machine.
    return const String.fromEnvironment(
      'API_HOST',
      defaultValue: 'http://localhost:8080',
    );
  }

  void init() {
    client = Client(
      _host,
      // Uncomment when running with Flutter web:
      // connectivityMonitor: null,
    );
  }
}