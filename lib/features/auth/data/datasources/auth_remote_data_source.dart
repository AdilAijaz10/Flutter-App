import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../Core/error/exceptions.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
  });

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await client.post(
      Uri.parse('$baseUrl/Auth/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'X-Tenant-ID': request.tenantId.toString(),
        'X-User-Email': request.email,
      },
      body: jsonEncode(request.toJson()),
    );

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200 && decoded['success'] == true) {
      return LoginResponseModel.fromJson(decoded['data'] as Map<String, dynamic>);
    }

    final message = decoded['message']?.toString() ?? 'Unable to login';
    throw ApiException(message, statusCode: response.statusCode);
  }
}


