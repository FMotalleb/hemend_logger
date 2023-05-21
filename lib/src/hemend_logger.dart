import 'package:hemend_logger/contracts/logger/logger.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_colors.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_logger.dart';
import 'package:hemend_logger/src/log_decorators/ansi_message_color_decorator.dart';
import 'package:hemend_logger/src/log_decorators/ansi_time_log_decorator.dart';
import 'package:logging/logging.dart';

/// {@template hemend-logger}
/// A simple implementation of the [ILogManager]
/// that provides a logging solution for the application
/// using the [Logger] form [`logging`](https://pub.dev/packages/logging) package
/// {@endtemplate}
class HemendLogger extends ILogManager {
  /// {@macro hemend-logger}
  ///
  /// *logger
  ///
  ///   Logging node that attached to this [ILogManager]
  ///
  ///   if you want to use a node other than [Logger.root] make sure
  ///   that you have enabled the [enableHierarchicalLogging] in the logging
  ///   package otherwise the initialization of this LogManager will fail
  HemendLogger({
    required Logger logger,
    bool enableHierarchicalLogging = false,
    List<ILogRecorder> initialListeners = const [],
  })  : _logger = logger,
        _listeners = [
          ...initialListeners,
        ] {
    if (logger.name.isNotEmpty && (hierarchicalLoggingEnabled == false)) {
      if (enableHierarchicalLogging) {
        hierarchicalLoggingEnabled = true;
      } else {
        throw Exception('''
you passed a logger that is not root and your logger is not able to record at hierarchy level 
you can enable it by passing [enableHierarchicalLogging]= true or
set `hierarchicalLoggingEnabled = true` before initialization of this manager.
''');
      }
    }
    _init();
  }

  void _init() {
    _logger.onRecord
        .map(
          (event) => LogRecordEntity(
            error: event.error,
            level: event.level.value,
            loggerName: event.loggerName,
            message: event.message,
            stackTrace: event.stackTrace,
            time: event.time,
            zone: event.zone,
          ),
        )
        .listen(onLog);
  }

  final Logger _logger;

  /// default log manager that attaches to [Logger.root] and records any log
  /// but logs from detached instances
  ///
  /// prints out log messages using the [AnsiLogger] with
  /// [ansiLogMessageColorDecorator] by default and a timeLogDecorator
  static HemendLogger defaultLogger = HemendLogger(
    logger: Logger.root,
    initialListeners: [
      AnsiLogger(
        logLevel: Logger.root.level.value,
        decoration: [
          ansiLogMessageColorDecorator(),
          timeLogDecorator(
            wrapper: (time) {
              final begin = AnsiColor.MAGENTA('<');
              final mid = AnsiColor.GREEN_BRIGHT(time);
              final end = AnsiColor.MAGENTA('>');
              return '$begin$mid$end';
            },
          ),
        ],
      ),
    ],
  );

  @override
  void addListener(ILogRecorder listener) {
    _listeners.add(listener);
  }

  @override
  int get logLevel => _logger.level.value;

  @override
  List<ILogRecorder> get listeners => _listeners.toList(growable: false);
  final List<ILogRecorder> _listeners;

  @override
  Future<void> onLog(LogRecordEntity record) async {
    for (final logger in listeners) {
      if (logger.canRecord(record)) {
        await logger.onRecord(record);
      }
    }
  }

  @override
  void removeListener(ILogRecorder listener) {
    _listeners.remove(listener);
  }
}
