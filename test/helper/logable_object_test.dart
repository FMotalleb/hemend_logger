// ignore_for_file: missing_override_of_must_be_overridden

import 'package:hemend_logger/hemend_logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'logable_object_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<Logger>(),
  ],
)
void main() {
  group('Logable Object', () {
    late MockLogger logger;
    late TesterObject testObject;
    setUp(() {
      logger = MockLogger();
      testObject = TesterObject(logger);
    });
    test(
      'logger check',
      () async {
        testObject = TesterObject(null);
        final newLogger = testObject.createSubLogger('test');
        expect(newLogger, isA<Logger>());
        expect(testObject.loggerName, isA<String>());
        expect(testObject.logger, isA<Logger>());
      },
    );
    test(
      'capture logs',
      () async {
        testObject.test();
        verifyInOrder(
          [
            logger.finest(any, any, any),
            logger.finer(any, any, any),
            logger.fine(any, any, any),
            logger.config(any, any, any),
            logger.info(any, any, any),
            logger.warning(any, any, any),
            logger.shout(any, any, any),
            logger.severe(any, any, any),
          ],
        );
      },
    );
  });
}

class TesterObject with LogableObject {
  TesterObject(this._internalLogger);

  final Logger? _internalLogger;
  @override
  Logger get logger => _internalLogger ?? super.logger;
  void test() {
    finest('this is finest with level value:${Level.FINEST.value}');
    finer('this is finer with level value:${Level.FINER.value}');
    fine('this is fine with level value:${Level.FINE.value}');
    config('this is config with level value:${Level.CONFIG.value}');
    info('this is info with level value:${Level.INFO.value}');
    warning('this is warning with level value:${Level.WARNING.value}');
    shout('this is shout with level value:${Level.SHOUT.value}');
    severe(
      'test error carrier',
      Exception('error happens'),
      StackTrace.current,
    );
  }
}
