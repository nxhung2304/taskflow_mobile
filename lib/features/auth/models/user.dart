import 'package:learn_getx/config/app_logging.dart';

class User {
  final int id;
  final String email;
  final String name;

  User({required this.id, required this.email, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    final logging = AppLogging();
    logging.d('Parsing user data: $json');

    try {
      final idValue = json['id'];
      final emailValue = json['email'];
      final nameValue = json['name'];

      return User(
        id: idValue ?? 0,
        email: emailValue?.toString() ?? '',
        name: nameValue?.toString() ?? '',
      );
    } catch (e) {
      logging.e('Error parsing user data: $e');
      return User(id: 0, email: '', name: '');
    }
  }
}
