part of 'logger.dart';

/// {@template log-levels}
/// You can find the values for levels in the [`logging`](https://github.com/dart-lang/logging/blob/master/lib/src/level.dart) package
/// default level for loggers is INFO which is `800` in integer value
/// {@endtemplate}

/// The [ILogManager] abstract class represents an abstraction of a LogManager.
///
/// It defines the essential methods and properties that a
/// LogManager should have.
abstract class ILogManager {
  /// The [listeners] property is a getter that returns a list of [ILogRecorder]
  /// objects.
  ///
  /// It represents the log recorders that are attached to this LogManager.
  /// LogManager manages and interacts with these log recorders for
  /// logging purposes.
  List<ILogRecorder> get listeners;

  /// The logLevel property represents the log level of this log manager
  /// instance.
  ///
  /// It indicates the minimum log level that will be recorded by
  /// the log recorders attached to this LogManager.
  ///
  /// The log level determines the severity or importance of logs that are
  /// recorded.
  ///
  /// {@macro log-levels}
  int get logLevel;

  /// The onLog method is invoked when a log record is received by
  /// the LogManager.
  ///
  /// It takes a LogRecordEntity object as a parameter,
  /// representing the log record that needs to be processed.
  ///
  /// The method iterates through the [listeners] (log recorders) attached to
  /// the LogManager and invokes the onRecord method of each recorder for
  /// recording the log, based on their individual recording criteria.
  void onLog(LogRecordEntity record) {
    if (record.level >= logLevel) {
      for (final recorder in listeners) {
        if (recorder.canRecord(record)) {
          recorder.onRecord(record);
        }
      }
    }
  }

  /// The [addListener] method is used to add a new [ILogRecorder] object as a
  /// [listener] to this log manager instance.
  ///
  /// It takes an [ILogRecorder] object as a parameter and attaches it to the
  /// LogManager.
  ///
  /// This allows the LogManager to forward log records to the added recorder
  /// for processing and recording.
  void addListener(ILogRecorder listener);

  /// The [removeListener] method is used to remove an [ILogRecorder] listener
  /// from this LogManager instance.
  ///
  /// It takes an [ILogRecorder] object as a parameter and removes it from
  /// the list of listeners.
  ///
  /// Additionally, it calls the close method of the listener to perform any
  /// necessary cleanup or finalization tasks associated with the listener.
  ///
  /// The @mustCallSuper annotation indicates
  /// that subclasses should invoke this method when overriding it.
  @mustCallSuper
  void removeListener(ILogRecorder listener) {
    listener.close();
  }
}
