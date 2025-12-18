import 'package:learn_getx/config/local_storage.dart';
import 'package:learn_getx/features/auth/constants/auth_constants.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';

class AuthHelpers {
  Future<void> clearAuthTokens() async {
    await LocalStorage.remove(AuthConstants.accessToken);
    await LocalStorage.remove(AuthConstants.uid);
    await LocalStorage.remove(AuthConstants.client);
    await LocalStorage.remove(AuthConstants.expiry);
  }

  bool validAuthTokens() {
    final tokens = AuthTokens.fromLocalStorage();

    return tokens.isValid();
  }

  Future<void> saveAuthTokens(AuthTokens authTokens) async {
    await LocalStorage.setString(
      AuthConstants.accessToken,
      authTokens.accessToken,
    );
    await LocalStorage.setString(AuthConstants.uid, authTokens.uid);
    await LocalStorage.setString(AuthConstants.client, authTokens.client);
    await LocalStorage.setString(AuthConstants.expiry, authTokens.expiry);
  }
}
