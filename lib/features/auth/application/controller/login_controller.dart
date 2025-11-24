import 'package:flutter/material.dart';

import '../../../../Core/error/failure.dart';
import '../../domain/entities/login_payload.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/usecases/login.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState {
  final LoginStatus status;
  final LoginResponse? data;
  final String? message;

  const LoginState({
    this.status = LoginStatus.initial,
    this.data,
    this.message,
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginResponse? data,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message,
    );
  }
}

class LoginController extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginState _state = const LoginState();

  LoginState get state => _state;

  LoginController({required this.loginUseCase});

  Future<void> login({
    required String email,
    required String password,
    required int tenantId,
  }) async {
    _state = _state.copyWith(status: LoginStatus.loading, message: null);
    notifyListeners();
    try {
      final payload = LoginPayload(
        email: email,
        password: password,
        tenantId: tenantId,
      );
      final response = await loginUseCase(payload);
      _state = LoginState(
        status: LoginStatus.success,
        data: response,
        message: 'Welcome back!',
      );
    } on Failure catch (failure) {
      _state = LoginState(
        status: LoginStatus.failure,
        message: failure.message,
      );
    } catch (error) {
      _state = LoginState(
        status: LoginStatus.failure,
        message: error.toString(),
      );
    }
    notifyListeners();
  }
}


