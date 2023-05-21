part of 'logger.dart';

/// {@template log_entity}
/// log record entity used inside this library
/// {@endtemplate}
class LogRecordEntity {
  /// {@macro log_entity}
  const LogRecordEntity({
    required this.error,
    required this.level,
    required this.loggerName,
    required this.message,
    required this.stackTrace,
    required this.time,
    required this.zone,
  });

  /// object of error carried by the log record
  final Object? error;

  /// log level of the record
  ///
  /// {@macro log-levels}
  final int level;

  /// the logger that reported this log-record
  final String loggerName;

  /// message from recorded log-record
  final String message;

  /// possible stacktrace carried by this log-record
  final StackTrace? stackTrace;

  /// date time that indicates when the log-record was recorded to logger
  final DateTime time;

  /// corresponding zone that this log-record was recorded from
  final Zone? zone;
}
