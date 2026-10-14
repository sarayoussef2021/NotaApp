import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ContactEndpoint extends Endpoint {
  Future<bool> send(
    Session session, {
    required String name,
    required String email,
    required String message,
    String locale = 'en',
  }) async {
    if (name.trim().isEmpty || email.trim().isEmpty || message.trim().isEmpty) {
      throw Exception('All fields are required');
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      throw Exception('Invalid email');
    }
    if (message.length > 5000) {
      throw Exception('Message too long');
    }

    await ContactMessage.db.insertRow(
      session,
      ContactMessage(
        name: name.trim(),
        email: email.trim().toLowerCase(),
        message: message.trim(),
        locale: locale,
        handled: false,
        createdAt: DateTime.now().toUtc(),
      ),
    );
    return true;
  }
}