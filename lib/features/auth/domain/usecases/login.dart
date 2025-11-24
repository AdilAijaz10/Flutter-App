import '../entities/login_payload.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  const LoginUseCase({required this.repository});

  Future<LoginResponse> call(LoginPayload payload) {
    return repository.login(payload);
  }
}


