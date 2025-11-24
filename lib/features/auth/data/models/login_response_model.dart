import '../../domain/entities/login_response.dart';

class LoginResponseModel extends LoginResponse {
  const LoginResponseModel({
    required super.token,
    required super.tenantId,
    required super.accessLevel,
    required super.loginTime,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] as String,
      tenantId: json['tenantId'] as int,
      accessLevel: json['accessLevel'] as String,
      loginTime: DateTime.parse(json['loginTime'] as String),
    );
  }
}


