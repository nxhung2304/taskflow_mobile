import 'package:learn_getx/config/local_storage.dart';

Future <void> bootstrap() async {
  await LocalStorage.init();
}
