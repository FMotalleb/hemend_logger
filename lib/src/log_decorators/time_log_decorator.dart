import 'package:hemend_logger/contracts/logger/log_decorator.dart';
import 'package:hemend_logger/contracts/logger/record.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_color.dart';

String _padLeft(int input) {
  return input.toString().padLeft(2, '0');
}

LogDecorator timeLogDecorator(
  AnsiColors color, {
  String? prefixChar = '(',
  String? postfix = ')',
}) {
  return (String message, LogRecordEntity record) {
    final buffer = StringBuffer();
    final formattedTime =
        '''${prefixChar ?? ''}${_padLeft(record.time.hour)}:${_padLeft(record.time.minute)}:${_padLeft(record.time.second)}${postfix ?? ''}''';

    buffer
      ..write(color(formattedTime))
      ..write(' ')
      ..write(message);
    return buffer.toString();
  };
}
