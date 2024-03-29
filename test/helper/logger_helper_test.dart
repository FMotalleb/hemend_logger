import 'package:hemend_logger/hemend_logger.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Logger Helper Extension',
    () {
      test(
        'get child returns normal name',
        () {
          const testName = 'test';
          final logger = Logger(testName);
          expect(
            logger.newChildLogger(testName).fullName,
            '$testName.$testName',
          );
          expect(
            logger.getChild(testName).fullName,
            '$testName.$testName',
          );
        },
      );
      test(
        'throw get child on detached',
        () {
          final logger = Logger.detached('test');
          expect(() => logger.newChildLogger('test-child'), throwsException);
          expect(() => logger.getChild('test-child'), throwsException);
        },
      );
      test(
        'get child returns same name as given for root logger',
        () {
          final logger = Logger.root;
          const testName = 'test';
          expect(logger.newChildLogger(testName).fullName, testName);
          expect(logger.getChild(testName).fullName, testName);
        },
      );
    },
  );
}
