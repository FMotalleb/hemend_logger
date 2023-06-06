import 'package:hemend_logger/hemend_logger.dart';
import 'package:test/test.dart';

void main() {
  group('AnsiColor', () {
    test(
      'MixedStyle test',
      () {
        final style = AnsiConsoleStyle(
          [
            AnsiColorStyle(
              color: AnsiColor.fromRgp(),
            ),
          ],
        );
        expect(() => style.value, throwsException);
        expect(style('test'), isA<String>());
      },
    );
    test(
      'Print test',
      () {
        final style = AnsiConsoleStyle(
          [
            AnsiColorStyle(
              color: AnsiColor.fromRgp(),
            ),
          ],
        );
        expect(() => style.value, throwsException);
        expect(style('test'), isA<String>());
      },
    );
  });
}
