import 'dart:convert';

import 'package:hemend_logger/src/contracts/logger/logger.dart';
import 'package:hemend_logger/src/json_logger/json_logger.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Json Output',
    () {
      String? result;
      final recorder = JsonLogger(
        logLevel: 0,
        output: (text) => result = text,
      );

      // ignore: cascade_invocations
      recorder.onRecord(
        LogRecordEntity(
          error: null,
          level: 100,
          loggerName: 'TestLogger',
          message: 'Test Message',
          stackTrace: null,
          time: DateTime(2020),
          zone: null,
        ),
      );
      expect(result, isA<String>());
      expect(jsonDecode(result!), isA<Map<String, dynamic>>());
    },
  );
}
