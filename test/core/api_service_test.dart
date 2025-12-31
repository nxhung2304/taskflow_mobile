import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:learn_getx/core/api_service.dart';
import 'package:learn_getx/features/auth/services/auth_token_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../helpers/test_data.dart';
import '../mocks/core/mock_app_logging.dart';
import '../mocks/core/mock_auth_token_storage.dart';
import '../mocks/core/mock_dio.dart';

void main() {
  group("ApiService", () {
    late MockAppLogging mockAppLogging;
    late MockDio mockDio;
    late MockAuthTokenStorage mockAuthTokenStorage;
    late MockInterceptors mockInterceptors;
    late ApiService apiService;

    setUpAll(() {
      registerFallbackValue(LogInterceptor());
      registerFallbackValue(<String, dynamic>{});
      registerFallbackValue(RequestOptions(path: ''));
    });

    setUp(() {
      mockAppLogging = MockAppLogging();
      mockDio = MockDio();
      mockAuthTokenStorage = MockAuthTokenStorage();
      mockInterceptors = MockInterceptors();

      getx.Get.testMode = true;
      getx.Get.put<AuthTokenStorage>(mockAuthTokenStorage);

      when(() => mockDio.options).thenReturn(ConfigTestData.validDioOptions);
      when(() => mockDio.interceptors).thenReturn(mockInterceptors);
      when(() => mockInterceptors.add(any())).thenReturn(null);
    });

    tearDown(() {
      getx.Get.reset();
    });

    ApiService createTestApiService({Dio? dio}) {
      return ApiService(
        baseUrl: 'https://api.example.com',
        connectTimeout: 30,
        receiveTimeout: 30,
        dio: dio ?? mockDio,
      );
    }

    MockResponse<T> createMockResponse<T>({
      required int statusCode,
      required T data,
      String? statusMessage,
    }) {
      final mockResponse = MockResponse<T>();
      when(() => mockResponse.statusCode).thenReturn(statusCode);
      when(() => mockResponse.data).thenReturn(data);
      if (statusMessage != null) {
        when(() => mockResponse.statusMessage).thenReturn(statusMessage);
      }
      return mockResponse;
    }

    group('HTTP Methods', () {
      test('get()', () async {
        final mockResponse = createMockResponse(
          data: {'success': true},
          statusCode: 200,
          statusMessage: 'OK',
        );
        when(
          () => mockDio.get("/test-get"),
        ).thenAnswer((_) async => mockResponse);

        apiService = createTestApiService();

        final response = await apiService.get("/test-get");

        expect(response.data, {'success': true});
        expect(response.statusCode, 200);
        verify(() => mockDio.get("/test-get")).called(1);
      });

      test('post()', () async {
        final mockResponse = createMockResponse(
          statusCode: 201,
          data: {'foo': 'bar'},
        );
        when(
          () => mockDio.post("/test-post", data: {'foo': 'bar'}),
        ).thenAnswer((_) async => mockResponse);

        apiService = createTestApiService();
        final response = await apiService.post(
          "/test-post",
          data: {'foo': 'bar'},
        );

        expect(response.data, {'foo': 'bar'});
        expect(response.statusCode, 201);
        verify(
          () => mockDio.post("/test-post", data: {'foo': 'bar'}),
        ).called(1);
      });

      test('patch()', () async {
        final mockResponse = createMockResponse(
          statusCode: 200,
          data: {'foo': 'bar'},
        );
        when(
          () => mockDio.patch("/test-patch", data: {'foo': 'bar'}),
        ).thenAnswer((_) async => mockResponse);

        apiService = createTestApiService();
        final response = await apiService.patch(
          "/test-patch",
          data: {'foo': 'bar'},
        );

        expect(response.data, {'foo': 'bar'});
        expect(response.statusCode, 200);
        verify(
          () => mockDio.patch("/test-patch", data: {'foo': 'bar'}),
        ).called(1);
      });

      test('delete()', () async {
        final mockResponse = createMockResponse(statusCode: 204, data: null);
        when(
          () => mockDio.delete("/test-delete"),
        ).thenAnswer((_) async => mockResponse);

        apiService = createTestApiService();
        final response = await apiService.delete("/test-delete");

        expect(response.statusCode, 204);
        verify(() => mockDio.delete("/test-delete")).called(1);
      });
    });

    group('Authentication Headers', () {
      group('restoreAuthHeaders()', () {
        test('should load tokens from storage', () async {
          final mockAuthTokens = ConfigTestData.validAuthTokens;
          when(() => mockAuthTokenStorage.load()).thenReturn(mockAuthTokens);
          when(() => mockAppLogging.d(any())).thenReturn(null);

          apiService = createTestApiService();

          verify(() => mockAuthTokenStorage.load()).called(1);
        });

        test("should set Dio headers if tokens are valid", () async {
          final mockAuthTokens = ConfigTestData.validAuthTokens;
          when(() => mockAuthTokenStorage.load()).thenReturn(mockAuthTokens);
          when(() => mockAppLogging.d(any())).thenReturn(null);

          apiService = createTestApiService();

          expect(
            mockDio.options.headers['access-token'],
            mockAuthTokens.accessToken,
          );
          expect(mockDio.options.headers['client'], mockAuthTokens.client);
          expect(mockDio.options.headers['uid'], mockAuthTokens.uid);
          expect(mockDio.options.headers['expiry'], mockAuthTokens.expiry);
        });

        test("should not set Dio headers if tokens are invalid", () async {
          final mockAuthTokens = ConfigTestData.invalidAuthTokens;
          when(() => mockAuthTokenStorage.load()).thenReturn(mockAuthTokens);

          apiService = createTestApiService();

          expect(mockDio.options.headers['access-token'], isNull);
          expect(mockDio.options.headers['client'], isNull);
          expect(mockDio.options.headers['uid'], isNull);
          expect(mockDio.options.headers['expiry'], isNull);
        });
      });

      group('clearAuthHeaders()', () {
        test("should clear tokens", () {
          final mockAuthTokens = ConfigTestData.validAuthTokens;
          when(() => mockAuthTokenStorage.load()).thenReturn(mockAuthTokens);
          when(() => mockAppLogging.d(any())).thenReturn(null);

          apiService = createTestApiService();
          apiService.clearAuthHeaders();

          expect(mockDio.options.headers['access-token'], isNull);
          expect(mockDio.options.headers['client'], isNull);
          expect(mockDio.options.headers['uid'], isNull);
          expect(mockDio.options.headers['expiry'], isNull);
        });
      });
    });

    group("Edge cases", () {
      test(
        'should handle Get.find<AuthTokenStorage>() service locator failure',
        () {
          getx.Get.reset();

          apiService = createTestApiService();

          expect(() => apiService, returnsNormally);
        },
      );

      test('should handle null tokens from storage', () {
        when(() => mockAuthTokenStorage.load()).thenReturn(null);

        apiService = createTestApiService();

        expect(() => apiService, returnsNormally);
      });
    });
  });
}
