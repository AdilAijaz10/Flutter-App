class LoginPayload {
  final String email;
  final String password;
  final int tenantId;

  const LoginPayload({
    required this.email,
    required this.password,
    required this.tenantId,
  });
}


