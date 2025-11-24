import '../../domain/entities/login_payload.dart';

class LoginRequestModel extends LoginPayload {
  const LoginRequestModel({
    required super.email,
    required super.password,
    required super.tenantId,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'tenantId': tenantId,
    };
  }
}


