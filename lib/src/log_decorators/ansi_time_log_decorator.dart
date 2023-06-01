import 'package:hemend_logger/src/contracts/logger/logger.dart';
import 'package:hemend_logger/src/contracts/typedefs.dart';

String _padLeft(int input) {
  return input.toString().padLeft(2, '0');
}

String _defaultFormatter(DateTime input) =>
    // ignore: lines_longer_than_80_chars
    '${_padLeft(input.hour)}:${_padLeft(input.minute)}:${_padLeft(input.second)}';

/// A log decorator that add time of the record behind the log-message
LogDecorator timeLogDecorator({
  String separator = ' ',
  Adapter<String, String>? wrapper,
  Adapter<DateTime, String> formatter = _defaultFormatter,
}) {
  return (String message, LogRecordEntity record) {
    final buffer = StringBuffer();
    final formattedTime = formatter(record.time);
    buffer
      ..write(wrapper?.call(formattedTime) ?? formattedTime)
      ..write(separator)
      ..write(message);
    return buffer.toString();
  };
}
