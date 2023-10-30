import 'package:hemend_logger/hemend_logger.dart';
import 'package:test/test.dart';

void main() {
  test('Convert levels to name', () {
    final testList = [
      ...Level.LEVELS,
      const Level('INFO', 850),
      const Level('-100', -100),
    ];
    for (final i in testList) {
      final result = HemendLogger.logLevel2Name(i.value);
      expect(result, matches(i.name));
    }
  });
}
