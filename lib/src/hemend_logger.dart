import 'package:hemend_logger/contracts/logger/app_logger.dart';
import 'package:hemend_logger/contracts/logger/log_printer.dart';
import 'package:hemend_logger/contracts/logger/record.dart';
import 'package:logging/logging.dart';

class HemendLogger extends ILogManager {
  /// returns the current instance of the selected logger
  /// on absence creates one instance and returns new instance
  factory HemendLogger({
    required Logger logger,
    List<ILogPrinter> initialListeners = const [],
  }) {
    final instance = _instances[logger.name];
    if (instance == null) {
      _instances[logger.name] = HemendLogger._(
        logger: logger,
        initialListeners: initialListeners,
      );
      final actualInstance = _instances[logger.name]! //
        ..init();
      return actualInstance;
    }
    return instance;
  }
  HemendLogger._({
    required Logger logger,
    List<ILogPrinter> initialListeners = const [],
  })  : _logger = logger,
        _listeners = [
          ...initialListeners,
        ];
  static final Map<String, HemendLogger> _instances = {};
  @override
  void init() {
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
  void addListener(ILogPrinter listener) {
    _listeners.add(listener);
  }

  @override
  int get logLevel => _logger.level.value;

  @override
  List<ILogPrinter> get listeners => _listeners.toList(growable: false);
  final List<ILogPrinter> _listeners;

  @override
  Future<void> onLog(LogRecordEntity record) async {
    for (final logger in _listeners) {
      if (logger.canRecord(record.level)) {
        await logger.onRecord(record);
      }
    }
  }

  @override
  void removeListener(ILogPrinter listener) {
    _listeners.remove(listener);
  }
}
