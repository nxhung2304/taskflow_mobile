import 'package:learn_getx/core/local_storage.dart';
import 'package:learn_getx/features/auth/constants/auth_constants.dart';
import 'package:learn_getx/features/auth/models/auth_tokens.dart';

class AuthTokenStorage {
  final ILocalStorage _localStorage;

  AuthTokenStorage(this._localStorage);

  Future<void> clear() async {
    await _localStorage.remove(AuthConstants.accessToken);
    await _localStorage.remove(AuthConstants.uid);
    await _localStorage.remove(AuthConstants.client);
    await _localStorage.remove(AuthConstants.expiry);
  }

  AuthTokens? load() {
    final accessToken = _localStorage.getString(AuthConstants.accessToken);
    final client = _localStorage.getString(AuthConstants.client);
    final uid = _localStorage.getString(AuthConstants.uid);
    final expiry = _localStorage.getString(AuthConstants.expiry);

    return AuthTokens(
      accessToken: accessToken ?? '',
      client: client ?? '',
      uid: uid ?? '',
      expiry: expiry ?? '',
    );
  }

  Future<void> save(AuthTokens authTokens) async {
    await _localStorage.setString(
      AuthConstants.accessToken,
      authTokens.accessToken,
    );
    await _localStorage.setString(AuthConstants.uid, authTokens.uid);
    await _localStorage.setString(AuthConstants.client, authTokens.client);
    await _localStorage.setString(AuthConstants.expiry, authTokens.expiry);
  }
}
