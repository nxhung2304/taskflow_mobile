import 'package:learn_getx/core/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

void main() {
  final dumpKey = 'foo';
  final dumpValue = 'bar';

  late SharedPreferences prefs;
  late LocalStorage storage;

  setUp(() async {
    SharedPreferences.setMockInitialValues({dumpKey: dumpValue});

    prefs = await SharedPreferences.getInstance();
    storage = LocalStorage(prefs);
  });

  group('LocalStorage', () {
    group("getString()", () {
      test('should return value for existed key', () async {
        final savedValue = storage.getString(dumpKey);

        expect(savedValue, dumpValue);
      });

      test("should return null value for key doesn't already exist", () async {
        final savedValue = LocalStorage(prefs).getString(dumpKey);

        expect(savedValue, isNull);
      });

      test(
        "should throw Exception('LocalStorage not initialized) when init() doesn't call",
        () {
          expect(() => storage.getString('foo'), throwsException);
        },
      );
    });

    group('setString()', () {
      test("should save value correct", () async {
        await storage.setString(dumpKey, dumpValue);

        final savedValue = storage.getString(dumpKey);

        expect(savedValue, dumpValue);
      });
    });

    group('remove()', () {
      test("should clear value success", () async {
        await storage.setString(dumpKey, dumpValue);
        await storage.remove(dumpKey);

        final savedValue = storage.getString(dumpKey);

        expect(savedValue, isNull);
      });
    });
  });
}
