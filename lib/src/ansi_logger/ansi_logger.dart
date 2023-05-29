import 'dart:developer';
// import 'dart:io';

import 'package:hemend_logger/hemend_logger.dart';

/// {@template ansi-logger}
/// Ansi logger that prints log records into the console
/// {@endtemplate}
class AnsiLogger extends ILogRecorder with DecoratedPrinter {
  /// {@macro ansi-logger}
  ///
  /// * log level
  ///
  ///   {@macro log-level}
  /// * recordAdapter
  ///
  ///   {@macro record-adapter}
  /// * decoration
  ///
  ///   {@macro log-decoration}
  AnsiLogger({
    required this.logLevel,
    this.recordAdapter = defaultAdapter,
    List<LogDecorator> decoration = const [],
  }) : decoration = [
          ...decoration,
          // _ansiDefaultDecorator,
        ];

  @override
  final List<LogDecorator> decoration;

  /// {@template record-adapter}
  /// as ansi logger only supports string we have to map the log record
  /// to string so by default we will only extract log-message but if
  /// you want to add a custom [recordAdapter] you can pass this parameter
  /// {@endtemplate}
  final Adapter<LogRecordEntity, String> recordAdapter;

  @override
  final int logLevel;

  @override
  void onRecord(LogRecordEntity record) {
    final message = _logFormatter(record);
    // stdout.add(message.codeUnits);
    log(
      message,
      level: record.level,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
      time: record.time,
      zone: record.zone,
    );
  }

  /// default log record adapter that only returns the [record].message
  static String defaultAdapter(LogRecordEntity record) => record.message;
  String _logFormatter(LogRecordEntity record) {
    final message = recordAdapter(record);

    return decorate(message, record);
  }
}

String _ansiDefaultDecorator(String message, LogRecordEntity record) {
  final loggerName = AnsiColor.YELLOW.wrap('[${record.loggerName}]');
  final buffer = StringBuffer()
    ..write(loggerName)
    ..write('\t')
    ..writeln(message);
  if (record.error != null) {
    final errorMessage = record.error.toString();
    final errorRepresentation = AnsiColor.RED_BRIGHT(errorMessage);
    buffer
      ..write('\t')
      ..writeln(errorRepresentation);
  }
  if (record.stackTrace != null) {
    final stackTraceMessage = record.stackTrace.toString();
    final stackTraceRepresentation = AnsiColor.RED_BRIGHT(stackTraceMessage);
    buffer.writeln(stackTraceRepresentation);
  }

  return buffer.toString();
}
