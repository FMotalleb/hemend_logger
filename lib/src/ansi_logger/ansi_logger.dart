import 'dart:developer';

import '../../hemend_logger.dart';

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
  /// * preferPrintOverLog
  ///
  ///   {@macro prefer-print}
  AnsiLogger({
    required this.preferPrintOverLog,
    required this.logLevel,
    List<LogDecorator> decoration = const [],
    this.recordAdapter = defaultAdapter,
  }) : decoration = [
          ...decoration,
          if (preferPrintOverLog) _ansiDefaultDecorator,
        ];

  @override
  final List<LogDecorator> decoration;

  /// {@template prefer-print}
  /// by default you can use [log] from developer package but you are unable
  /// to use this method in release mode this flag will make sure that you are
  /// able too see messages even in production mode
  /// {@endtemplate}
  final bool preferPrintOverLog;

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
    if (preferPrintOverLog) {
      // ignore: avoid_print
      print(message);
    } else {
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
  }

  /// default log record adapter that only returns the [record].message
  static String defaultAdapter(LogRecordEntity record) => record.message;
  String _logFormatter(LogRecordEntity record) {
    final message = recordAdapter(record);

    return decorate(message, record);
  }
}

String _ansiDefaultDecorator(String message, LogRecordEntity record) {
  const yellow = AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: RgbAnsiColor(195, 170, 25),
      ),
    ],
  );
  const red = AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: RgbAnsiColor(255, 10, 30),
      ),
    ],
  );
  const redDark = AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: RgbAnsiColor(150, 150, 0),
      ),
    ],
  );
  final loggerName = yellow(
    '[${record.loggerName}]',
  );
  final buffer = StringBuffer()
    ..write(loggerName)
    ..write('\t')
    ..write(message);
  if (record.error != null) {
    final errorMessage = record.error.toString();
    final errorRepresentation = red(errorMessage);
    buffer
      ..write('\n\t')
      ..write(errorRepresentation);
  }
  if (record.stackTrace != null) {
    final stackTraceMessage = record.stackTrace.toString().split('\n');
    final stackTraceRepresentation = stackTraceMessage.map(redDark.call).join(
          '\n',
        );
    buffer
      ..write('\n')
      ..write(stackTraceRepresentation);
  }

  return buffer.toString();
}
