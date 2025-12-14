import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_getx/bootstrap.dart';
import 'package:learn_getx/config/app_bindings.dart';
import 'package:learn_getx/config/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
      initialBinding: AppBindings(),
    );
  }
}
