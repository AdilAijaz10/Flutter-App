class LoginResponse {
  final String token;
  final int tenantId;
  final String accessLevel;
  final DateTime loginTime;

  const LoginResponse({
    required this.token,
    required this.tenantId,
    required this.accessLevel,
    required this.loginTime,
  });
}


