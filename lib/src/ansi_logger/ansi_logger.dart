import 'dart:developer';

import 'package:hemend_logger/src/contracts/logger/logger.dart';
import 'package:hemend_logger/src/contracts/typedefs.dart';

/// {@template ansi-logger}
/// Ansi logger that prints log records into the console
/// using [log] from [dart:developer] package.
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
    this.decoration = const [],
  });

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
