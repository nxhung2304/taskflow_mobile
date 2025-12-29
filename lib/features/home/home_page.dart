import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/features/auth/controllers/auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async => await authController.logout(),
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}
