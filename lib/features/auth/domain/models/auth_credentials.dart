/// Immutable value object carrying login input.
class AuthCredentials {
  const AuthCredentials({
    required this.badgeNumber,
    required this.password,
  });

  final String badgeNumber;
  final String password;
}
