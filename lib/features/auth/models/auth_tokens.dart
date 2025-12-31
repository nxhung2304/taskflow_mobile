class AuthTokens {
  final String accessToken;
  final String client;
  final String uid;
  final String expiry;

  const AuthTokens({
    required this.accessToken,
    required this.client,
    required this.uid,
    required this.expiry,
  });

  factory AuthTokens.fromMap(Map<String, String> map) {
    return AuthTokens(
      accessToken: map['access-token'] ?? '',
      client: map['client'] ?? '',
      uid: map['uid'] ?? '',
      expiry: map['expiry'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'client': client,
    'uid': uid,
    'expiry': expiry,
  };

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['accessToken'] ?? '',
      client: json['client'] ?? '',
      uid: json['uid'] ?? '',
      expiry: json['expiry'] ?? '',
    );
  }

  factory AuthTokens.fromHeaders(headers) {
    return AuthTokens(
      accessToken: headers['access-token']?.first ?? '',
      client: headers['client']?.first ?? '',
      uid: headers['uid']?.first ?? '',
      expiry: headers['expiry']?.first ?? '',
    );
  }

  bool isExpired() {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final exp = int.tryParse(expiry) ?? 0;
    return now > exp;
  }

  bool isValid() {
    if (accessToken.isEmpty) return false;
    if (client.isEmpty) return false;
    if (expiry.isEmpty) return false;
    if (uid.isEmpty) return false;
    if (isExpired()) return false;

    return true;
  }

  @override
  String toString() =>
      'AuthTokens(access: $accessToken, client: $client, uid: $uid, expiry: $expiry)';
}
