part of 'logger.dart';

/// {@template log_entity}
/// It is used to encapsulate information about a log record, including
///
/// the log message,
///
/// log level,
///
/// logger name,
///
/// timestamp,
///
/// and optional error and stack trace information.
/// {@endtemplate}
class LogRecordEntity {
  /// {@macro log_entity}
  ///
  ///
  /// The constructor of the LogRecordEntity class takes named parameters and
  /// initializes the corresponding fields of the class.
  ///
  /// It requires the following parameters:
  /// * `error`: An object representing the error associated with
  /// the log record.
  /// * `level`: An integer representing the log level of the record.
  /// * `loggerName`: A string indicating the name of the logger that reported
  /// the log record.
  /// * `message`: A string representing the message of the log record.
  /// * `stackTrace`: An optional StackTrace object representing
  /// the stack trace associated with the log record.
  /// * `time`: A DateTime object indicating the timestamp when
  /// the log record was recorded to the logger.
  /// * `zone`: An optional Zone object representing the corresponding zone
  /// from which the log record was recorded.
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
