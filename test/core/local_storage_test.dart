import 'package:learn_getx/core/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  final dumpKey = 'foo';
  final dumpValue = 'bar';

  group('LocalStorage', () {
    group("init()", () {
      test(
        "should initialize LocalStorage if it doesn't already exist",
        () async {
          await LocalStorage.init();

          expect(LocalStorage.shared, isNotNull);
        },
      );

      test("should not initialize LocalStorage if it already exists", () async {
        await LocalStorage.init();

        final firstInstance = LocalStorage.shared;

        await LocalStorage.init();
        final secondInstance = LocalStorage.shared;

        expect(identical(firstInstance, secondInstance), isTrue);
      });

      test("should initialize LocalStorage after reset() called", () async {
        LocalStorage.reset();

        await LocalStorage.init();

        expect(LocalStorage.shared, isNotNull);
      });
    });

    group("getString()", () {
      test('should return value for existed key', () async {
        SharedPreferences.setMockInitialValues({dumpKey: dumpValue});
        await LocalStorage.init();

        final savedValue = LocalStorage.getString(dumpKey);

        expect(savedValue, dumpValue);
      });

      test("should return null value for key doesn't already exist", () async {
        await LocalStorage.init();

        final savedValue = LocalStorage.getString(dumpKey);

        expect(savedValue, isNull);
      });

      test(
        "should throw Exception('LocalStorage not initialized) when init() doesn't call",
        () {
          expect(() => LocalStorage.getString('foo'), throwsException);
        },
      );
    });

    group('setString()', () {
      test("should save value correct", () async {
        await LocalStorage.init();

        await LocalStorage.setString(dumpKey, dumpValue);

        final savedValue = LocalStorage.getString(dumpKey);

        expect(savedValue, dumpValue);
      });

       test(
        "should throw Exception('LocalStorage not initialized) when init() doesn't call",
        () {
          expect(() => LocalStorage.setString(dumpKey, dumpValue), throwsException);
        },
      );
    });

    group('remove()', () {
      test("should clear value success", () async {
        await LocalStorage.init();

        await LocalStorage.setString(dumpKey, dumpValue);
        await LocalStorage.remove(dumpKey);

        final savedValue = LocalStorage.getString(dumpKey);

        expect(savedValue, isNull);
      });

       test(
        "should throw Exception('LocalStorage not initialized) when init() doesn't call",
        () async {
          expect(() async => await LocalStorage.remove(dumpKey), throwsException);
        },
      );
    });

    group('reset()', () {
      test("should reset _prefs success", () {
        LocalStorage.reset();

        expect(LocalStorage.shared, isNull);
      });
    });
  });
}
