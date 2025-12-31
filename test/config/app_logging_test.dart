import 'package:learn_getx/config/app_logging.dart';
import 'package:test/test.dart';

import 'package:mocktail/mocktail.dart';

class MockAppLogging extends Mock implements AppLogging {}

void main() {
  group('AppLogging', () {
    late AppLogging appLogging;

    setUpAll(() {
      registerFallbackValue('');
    });

    setUp(() {
      appLogging = AppLogging();
    });

    test('getCallerName() should return correct caller format', () {
      final callerName = appLogging.getCallerName();

      expect(callerName, 'Unknown');
    });
  });
}
