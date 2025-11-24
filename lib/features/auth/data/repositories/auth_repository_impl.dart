import '../../../../Core/error/exceptions.dart';
import '../../../../Core/error/failure.dart';
import '../../domain/entities/login_payload.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<LoginResponse> login(LoginPayload payload) async {
    try {
      final request = LoginRequestModel(
        email: payload.email,
        password: payload.password,
        tenantId: payload.tenantId,
      );
      return await remoteDataSource.login(request);
    } on ApiException catch (exception) {
      throw Failure(exception.message);
    } catch (error) {
      throw Failure(error.toString());
    }
  }
}


