part of 'logger.dart';

/// {@template log-levels}
/// You can find the values for levels in the [`logging`](https://github.com/dart-lang/logging/blob/master/lib/src/level.dart) package
/// default level for loggers is INFO which is `800` in integer value
/// {@endtemplate}

/// an abstraction of what a LogManager should have
abstract class ILogManager {
  /// [ILogRecorder]s that are attached to this [ILogManager]
  List<ILogRecorder> get listeners;

  /// Log level of this log manager instance
  ///
  /// {@macro log-levels}
  int get logLevel;

  /// a method that receives log records and invokes the corresponding
  /// [listeners] which are [ILogRecorder]
  Future<void> onLog(LogRecordEntity record) async {
    for (final recorder in listeners) {
      if (recorder.canRecord(record)) {
        await recorder.onRecord(record);
      }
    }
  }

  /// add new [ILogRecorder] as listener to this log manager instance
  void addListener(ILogRecorder listener);

  /// removes one of [ILogRecorder] listeners of this instance
  void removeListener(ILogRecorder listener);
}
