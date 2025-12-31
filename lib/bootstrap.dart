import 'package:learn_getx/core/local_storage.dart';

Future <void> bootstrap() async {
  await LocalStorage.init();
}
