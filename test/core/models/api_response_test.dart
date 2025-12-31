import 'package:learn_getx/core/models/api_response.dart';
import 'package:test/test.dart';

void main() {
  group('ApiResponse', () {
    test("fromJson map full json correctly", () {
      final dumpJson = {
        'success': true,
        'message': 'OK',
        'data': {'id': 1},
      };

      final result = ApiResponse.fromJson(dumpJson);

      expect(result.success, true);
      expect(result.message, 'OK');
      expect(result.data, {'id': 1});
    });

    test("success is false when success != true", () {
      final dumpJson = {'success': false, 'message': 'Fail'};

      final result = ApiResponse.fromJson(dumpJson);

      expect(result.success, false);
    });

    test("message defaults to empty when null", () {
      final dumpJson = {'success': false, 'message': null};

      final result = ApiResponse.fromJson(dumpJson);

      expect(result.message, isEmpty);
    });

    test("data can be null", () {
      final dumpJson = {'success': true, "message": "OK", "data": null};

      final result = ApiResponse.fromJson(dumpJson);

      expect(result.data, isNull);
    });

    test('handles missing fields gracefully', () {
      final json = <String, dynamic>{};

      final result = ApiResponse.fromJson(json);

      expect(result.success, false);
      expect(result.message, '');
      expect(result.data, isNull);
    });
  });
}
