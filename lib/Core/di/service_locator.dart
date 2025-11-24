import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '../network/api_constants.dart';
import '../../features/auth/application/controller/login_controller.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  sl
    ..registerLazySingleton<http.Client>(http.Client.new)
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        client: sl(),
        baseUrl: ApiConstants.baseUrl,
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    )
    ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: sl()),
    )
    ..registerFactory<LoginController>(
      () => LoginController(loginUseCase: sl()),
    );
}


