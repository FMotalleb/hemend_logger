import 'package:hemend_logger/hemend_logger.dart';

/// this variable is not available in dart but this will work in flutter
const kDebugMode = (bool.fromEnvironment('dart.vm.product') == false) && //
    (bool.fromEnvironment('dart.vm.profile') == false);

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
    if (logger.parent != null && hierarchicalLoggingEnabled == false) {
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

  /// default log manager that attaches to [Logger.root] and records any log
  /// but logs from detached instances
  ///
  /// prints out log messages using the [AnsiLogger] with
  /// [ansiLogMessageColorDecorator] by default and a timeLogDecorator
  factory HemendLogger.defaultLogger({
    Logger? logger,
    bool preferPrintOverLog = !kDebugMode,
  }) =>
      HemendLogger(
        logger: logger ?? Logger.root,
        enableHierarchicalLogging: logger?.parent != null,
        initialListeners: [
          AnsiLogger(
            preferPrintOverLog: preferPrintOverLog,
            logLevel: (logger ?? Logger.root).level.value,
            decoration: [
              ansiLogMessageColorDecorator(),
              timeLogDecorator(
                wrapper: (time) {
                  const magenta = AnsiConsoleStyle(
                    [
                      AnsiColorStyle(color: AnsiColor.magenta),
                    ],
                  );
                  const green = AnsiConsoleStyle(
                    [
                      AnsiColorStyle(
                        color: AnsiColor.green,
                        mode: AnsiColorMode.lightForeground,
                      ),
                      AnsiTextEffect.underLine,
                    ],
                  );
                  return magenta.wrap('<') +
                      green.wrap(time) +
                      magenta.wrap(
                        '>',
                      );
                },
              ),
            ],
          ),
        ],
      );

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

  @override
  int get logLevel => _logger.level.value;

  @override
  List<ILogRecorder> get listeners => _listeners.toList(growable: false);
  final List<ILogRecorder> _listeners;

  @override
  void addListener(ILogRecorder listener) {
    _listeners.add(listener);
  }

  @override
  void removeListener(ILogRecorder listener) {
    _listeners.remove(listener);
    super.removeListener(listener);
  }
}
