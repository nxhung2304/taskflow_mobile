import 'package:get/get.dart';

class LoginForm {
  final String email;
  final String password;

  LoginForm({
    required this.email,
    required this.password,
  });

  String? validateEmail() {
    if (email.isEmpty) return 'Email cannot be empty';

    if (!GetUtils.isEmail(email)) return 'Invalid email format';

    return null;
  }

  String? validatePassword() {
    if (password.isEmpty) return 'Password cannot be empty';

    if (password.length < 6) return 'Password must be at least 6 characters';

    return null;
  }

  String? validate() {
    return validateEmail() ?? validatePassword();
  }
}
