import 'package:learn_getx/config/local_storage.dart';
import 'package:learn_getx/features/auth/constants/auth_constants.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';

class AuthTokenStorage {
  Future<void> clear() async {
    await LocalStorage.remove(AuthConstants.accessToken);
    await LocalStorage.remove(AuthConstants.uid);
    await LocalStorage.remove(AuthConstants.client);
    await LocalStorage.remove(AuthConstants.expiry);
  }

  AuthTokens load() {
    final accessToken = LocalStorage.getString(AuthConstants.accessToken);
    final client = LocalStorage.getString(AuthConstants.client);
    final uid = LocalStorage.getString(AuthConstants.uid);
    final expiry = LocalStorage.getString(AuthConstants.expiry);

    return AuthTokens(
      accessToken: accessToken ?? '',
      client: client ?? '',
      uid: uid ?? '',
      expiry: expiry ?? '',
    );
  }

  Future<void> save(AuthTokens authTokens) async {
    await LocalStorage.setString(
      AuthConstants.accessToken,
      authTokens.accessToken,
    );
    await LocalStorage.setString(AuthConstants.uid, authTokens.uid);
    await LocalStorage.setString(AuthConstants.client, authTokens.client);
    await LocalStorage.setString(AuthConstants.expiry, authTokens.expiry);
  }
}
