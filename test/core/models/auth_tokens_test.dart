import 'package:learn_getx/features/auth/models/auth_tokens.dart';
import 'package:test/test.dart';

void main() {
  final accessToken = "access-token";
  final client = "client";
  final uid = "uid";
  final expiry =
      (DateTime.now().add(const Duration(minutes: 30)).millisecondsSinceEpoch ~/
              1000)
          .toString();

  final authTokensJson = {
    'access-token': "access-token",
    "client": "client",
    "uid": "uid",
    "expiry": expiry,
  };
  final validAuthTokens = AuthTokens(
    accessToken: accessToken,
    client: client,
    uid: uid,
    expiry: expiry,
  );

  group("AuthTokens", () {
    group("Constructor and Factory methods", () {
      test("create AuthTokens with constructor", () {
        expect(validAuthTokens.accessToken, accessToken);
        expect(validAuthTokens.client, client);
        expect(validAuthTokens.expiry, expiry);
        expect(validAuthTokens.uid, uid);
      });

      group("fromJson()", () {
        test("should parsed to valid AuthToken", () {
          final authTokens = AuthTokens.fromJson(authTokensJson);

          expect(authTokens.accessToken, accessToken);
          expect(authTokens.client, client);
          expect(authTokens.expiry, expiry);
          expect(authTokens.uid, uid);
        });

        test(
          "should parsed to default AuthToken ( empty string for values)",
          () {
            final defaultAuthTokens = AuthTokens.fromJson({});

            expect(defaultAuthTokens.accessToken, '');
            expect(defaultAuthTokens.client, '');
            expect(defaultAuthTokens.expiry, '');
            expect(defaultAuthTokens.uid, '');
          },
        );
      });

      group("toJson", () {
        test("should parsed to valid json", () {
          final parsedAuthTokensJson = validAuthTokens.toJson();

          expect(parsedAuthTokensJson['access-token'], accessToken);
          expect(parsedAuthTokensJson["client"], client);
          expect(parsedAuthTokensJson["uid"], uid);
          expect(parsedAuthTokensJson["expiry"], expiry);
        });
      });

      group('fromHeaders', () {
        test('should parsed to valid AuthTokens', () {
          final validHeaders = {
            'access-token': [accessToken],
            'client': [client],
            'uid': [uid],
            'expiry': [expiry],
          };

          final authTokens = AuthTokens.fromHeaders(validHeaders);

          expect(authTokens.accessToken, accessToken);
          expect(authTokens.client, client);
          expect(authTokens.expiry, expiry);
          expect(authTokens.uid, uid);
        });

        test('should return a default AuthTokens ( empty values )', () {
          final emptyHeaders = {"": null};

          final authTokens = AuthTokens.fromHeaders(emptyHeaders);

          expect(authTokens.accessToken, '');
          expect(authTokens.client, '');
          expect(authTokens.expiry, '');
          expect(authTokens.uid, '');
        });
      });

      group('toJson', () {
        test('should converted to valid json', () {
          final parsedJson = validAuthTokens.toJson();

          expect(parsedJson['access-token'], accessToken);
          expect(parsedJson['client'], client);
          expect(parsedJson['uid'], uid);
          expect(parsedJson['expiry'], expiry);
        });

        test(
          'convert to toJson and rollback by fromJson -> data not changed',
          () {
            final parsedJson = validAuthTokens.toJson();
            final rollbackedAuthToken = AuthTokens.fromJson(parsedJson);

            expect(
              rollbackedAuthToken.accessToken,
              validAuthTokens.accessToken,
            );
            expect(rollbackedAuthToken.client, validAuthTokens.client);
            expect(rollbackedAuthToken.uid, validAuthTokens.uid);
            expect(rollbackedAuthToken.expiry, validAuthTokens.expiry);
          },
        );
      });
    });

    group('Validation', () {
      group("isExpired", () {
        test("should return false when not yet expired", () {
          expect(validAuthTokens.isExpired(), false);
        });
      });
    });
  });
}
