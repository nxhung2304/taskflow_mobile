import 'package:dio/dio.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';

class ConfigTestData {
  static const validAuthTokens = AuthTokens(
    uid: 'test@example',
    client: 'valid_client_token',
    accessToken: 'valid_access_token',
    expiry: '9999999999',
  );

  static const invalidAuthTokens = AuthTokens(
    accessToken: '',
    client: '',
    uid: '',
    expiry: '',
  );

  static final validDioOptions = BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  );
}
