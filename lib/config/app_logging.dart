import 'package:flutter/foundation.dart';

class AppLogging {
  d(String message) {
    if (kDebugMode) {
      final caller = _getCaller();
      debugPrint("[$caller] $message");
    }
  }

  void i(String message) {
    if (kDebugMode) {
      final caller = _getCaller();
      debugPrint("[$caller] ℹ $message");
    }
  }

  void e(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      final caller = _getCaller();
      debugPrint("[$caller] ❌ $message");
      if (error != null) debugPrint("Error: $error");
      if (stackTrace != null) debugPrint(stackTrace.toString());
    }
  }

  void w(String message) {
    if (kDebugMode) {
      final caller = _getCaller();
      debugPrint("[$caller] ⚠ $message");
    }
  }

  String getCallerName() {
    return _getCaller();
  }

  String _getCaller() {
    var caller = 'Unknown';
    try {
      final frames = StackTrace.current.toString().split('\n');

      for (final frame in frames) {
        if (frame.contains('AppLogging') || frame.trim().isEmpty) continue;

        final regex = RegExp(r'#\d+\s+(\w+)\.(\w+)\s');
        final match = regex.firstMatch(frame);

        if (match != null) {
          final className = match.group(1);
          final methodName = match.group(2);
          caller = '$className#$methodName';
        }
      }
    } catch (_) {}

    return caller;
  }
}
