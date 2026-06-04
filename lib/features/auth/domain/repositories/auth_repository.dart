import '../../../officers/domain/models/officer.dart';

/// Contract for authentication operations.
abstract class AuthRepository {
  /// Returns the authenticated [Officer] on success, or [null] on failure.
  /// Throws [AuthException] for unexpected errors.
  Future<Officer?> login(String badgeNumber, String password);

  /// Clears any cached session state.
  Future<void> logout();
}

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => 'AuthException: $message';
}
