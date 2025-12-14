class AppEndpoint {
  // TODO: use flavor to change baseUrl for different environments
  static const String baseUrl = "http://192.168.1.46:3030/api/v1";

  // Auth
  static const String login = "/auth/sign_in";
  static const String logout = "/auth/sign_in";

  // Users
  static const String me = "/users/me";
}
