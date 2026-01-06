import 'package:learn_getx/core/local_storage.dart';
import 'package:learn_getx/features/auth/constants/auth_constants.dart';
import 'package:learn_getx/features/auth/data/auth_token_storage.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockILocalStorage extends Mock implements ILocalStorage {}

void main() {
  final uid = 'uid';
  final client = 'client';
  final expiry = 'expiry';
  final accessToken = 'access-token';
  final authTokens = AuthTokens(
    accessToken: accessToken,
    client: client,
    uid: uid,
    expiry: expiry,
  );

  late AuthTokenStorage authTokenStorage;
  late MockILocalStorage mockLocalStorage;

  setUp(() async {
    mockLocalStorage = MockILocalStorage();
    authTokenStorage = AuthTokenStorage(mockLocalStorage);
  });

  group('AuthTokenStorage', () {
    group("clear()", () async {
      test('should remove all 4 auth tokens from storage', () async {
        await authTokenStorage.clear();

        verify(
          () => mockLocalStorage.remove(AuthConstants.accessToken),
        ).called(1);
        verify(() => mockLocalStorage.remove(AuthConstants.uid)).called(1);
        verify(() => mockLocalStorage.remove(AuthConstants.client)).called(1);
        verify(() => mockLocalStorage.remove(AuthConstants.expiry)).called(1);
      });
    });

    group("save()", () {
      test("should save for 4 auth tokens to storage", () async {
        await authTokenStorage.save(authTokens);

        verify(
          () => mockLocalStorage.setString(
            AuthConstants.accessToken,
            accessToken,
          ),
        ).called(1);
        verify(
          () => mockLocalStorage.setString(AuthConstants.uid, uid),
        ).called(1);
        verify(
          () => mockLocalStorage.setString(AuthConstants.client, client),
        ).called(1);
        verify(
          () => mockLocalStorage.setString(AuthConstants.expiry, expiry),
        ).called(1);
      });
    });

    group("load", () {
      test('should get valid auth tokens saved before', () async {
        when(
          () => mockLocalStorage.getString(AuthConstants.accessToken),
        ).thenReturn(accessToken);
        when(
          () => mockLocalStorage.getString(AuthConstants.uid),
        ).thenReturn(uid);
        when(
          () => mockLocalStorage.getString(AuthConstants.client),
        ).thenReturn(client);
        when(
          () => mockLocalStorage.getString(AuthConstants.expiry),
        ).thenReturn(expiry);

        final savedAuthTokens = authTokenStorage.load();

        expect(savedAuthTokens, authTokens);
      });

      test("should get default values for auth tokens", () {
        final savedAuthTokens = authTokenStorage.load();

        expect(savedAuthTokens?.accessToken, '');
        expect(savedAuthTokens?.client, '');
        expect(savedAuthTokens?.uid, '');
        expect(savedAuthTokens?.expiry, '');
      });
    });
  });
}
