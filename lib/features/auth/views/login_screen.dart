import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/features/auth/controllers/auth_controller.dart';
import 'package:learn_getx/features/auth/forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Scaffold(
      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                authController.error.value,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    authController.email.value = value;
                  },
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    authController.password.value = value;
                  },
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleLogin(authController),
                child:
                    authController.isLoading.value
                        ? CircularProgressIndicator()
                        : Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _handleLogin(AuthController authController) {
    if (authController.isLoading.value) return;

    final form = LoginForm(
      email: authController.email.value,
      password: authController.password.value,
    );

    authController.login(form);
  }
}
