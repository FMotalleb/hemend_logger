part of 'logger.dart';

/// {@template log-recorder}
/// Abstraction of log recorder that can be attached to a [ILogManager]
/// {@endtemplate}
abstract class ILogRecorder {
  /// {@macro log-recorder}
  const ILogRecorder();

  /// {@template log-level}
  /// log level of log recorder instance
  ///
  /// {@macro log-levels}
  /// {@endtemplate}
  int get logLevel;

  /// validates that this recorder should record the current log-record
  ///
  /// by default validates that current recorder level must be
  /// equal or less than log-record's log level
  bool canRecord(LogRecordEntity record) {
    return logLevel <= record.level;
  }

  /// method that will be called when the manager received a new log-record
  /// that can be recorded by this recorder
  void onRecord(LogRecordEntity record);
}
