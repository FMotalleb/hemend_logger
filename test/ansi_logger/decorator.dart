import 'package:hemend_logger/hemend_logger.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test',
    () {
      test('default decorator', () {
        final timeDecorator = timeLogDecorator();
        final testLog = LogRecordEntity(
          error: null,
          level: 800,
          loggerName: '',
          message: 'test',
          stackTrace: null,
          time: DateTime.now(),
          zone: null,
        );

        expect(
          timeDecorator(
            'tst',
            testLog,
          ),
          isA<String>(),
        );
      });
    },
  );
}
