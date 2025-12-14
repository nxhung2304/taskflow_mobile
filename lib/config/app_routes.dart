import 'package:get/get.dart';
import 'package:learn_getx/features/auth/bindings/auth_binding.dart';
import 'package:learn_getx/features/auth/views/login_screen.dart';
import 'package:learn_getx/features/home/home_binding.dart';
import 'package:learn_getx/features/home/home_page.dart';
import 'package:learn_getx/features/splash/splash_binding.dart';
import 'package:learn_getx/features/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';

  static final pages = [
    // Splash
    GetPage(name: splash, page: () => SplashScreen(), binding: SplashBinding()),

    // Auth
    GetPage(name: login, page: () => LoginScreen(), binding: AuthBinding()),

    // LoggedIn
    GetPage(
      name: home,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
