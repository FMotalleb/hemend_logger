part of 'logger.dart';

/// {@template log-recorder}
/// The purpose of this abstraction is to define a common interface or contract
/// for different types of log recorders.
///
/// By implementing this class, different log recorders can adhere to the same
/// interface.
/// {@endtemplate}
abstract class ILogRecorder {
  /// {@macro log-recorder}
  const ILogRecorder();

  /// {@template log-level}
  /// The logLevel getter returns the log level of the log recorder instance.
  /// This log level represents the minimum level of logs
  /// that will be recorded by this recorder.
  ///
  /// {@macro log-levels}
  /// {@endtemplate}
  int get logLevel;

  ///validate whether the current log record should be recorded by
  ///the log recorder instance. By default, it checks if the log level of
  ///the log recorder is equal to or less than the log level of
  ///the given record parameter.
  ///
  ///The method takes a LogRecordEntity object as a parameter,representing
  ///the log record to be validated. It returns a boolean value indicating
  ///whether the log record should be recorded or not.
  bool canRecord(LogRecordEntity record) {
    return logLevel <= record.level;
  }

  /// a callback that will be invoked when the manager receives a new log record
  /// that can be recorded by this specific recorder.
  /// It takes a LogRecordEntity object as a parameter, representing
  /// the log record that was received.
  ///
  /// Inside this method, you can define the actions or operations
  /// that need to be performed when a new log record is received and is
  /// eligible for recording by this recorder. This could include writing
  /// the log record to a log file, sending it to a logging service, or
  /// performing any other desired logging-related tasks.
  void onRecord(LogRecordEntity record);

  /// called when this particular log recorder is removed from the manager.
  /// It serves as a cleanup or finalization method for any resources or
  /// operations associated with the log recorder.
  void close() {}
}
