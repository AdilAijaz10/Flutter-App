import '../entities/login_payload.dart';
import '../entities/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginPayload payload);
}


