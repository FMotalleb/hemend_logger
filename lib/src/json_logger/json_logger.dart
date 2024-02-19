import 'dart:convert';

import '../../hemend_logger.dart';

/// Adapter from [LogRecordEntity] to [Map]
typedef RecordMapper = Adapter<LogRecordEntity, Map<String, dynamic>>;

/// Json Serializer from [Map] to [String]
typedef JsonSerializer = Adapter<Map<String, dynamic>, String>;

/// {@template json-logger}
/// The [JsonLogger] class is a logger that records log messages in
/// JSON format.
///
/// It implements the [ILogRecorder] interface and provides the following
/// features:
///
///  * supports configurable log levels.
///  * can be used to record log messages to any output stream, such as the
/// console, a file, or a network socket.
///  * uses a customizable mapper to convert LogRecordEntity objects to JSON
/// maps.
///  * uses a customizable serializer to serialize JSON maps to strings.
/// {@endtemplate}
final class JsonLogger extends ILogRecorder {
  /// {@macro json-logger}
  JsonLogger({
    required this.logLevel,
    RecordMapper? mapper,
    JsonSerializer? serializer,
    this.output = print,
  })  : mapper = mapper ?? _defaultMapper,
        serializer = serializer ?? jsonEncode;

  /// The mapper that converts LogRecordEntity objects to JSON maps.
  final RecordMapper mapper;

  /// The serializer that serializes JSON maps to strings.
  final JsonSerializer serializer;

  /// The output stream to which log messages will be recorded.
  final void Function(String) output;
  @override
  final int logLevel;

  @override
  void onRecord(LogRecordEntity record) {
    final map = mapper(record);
    final result = serializer(map);
    output(result);
  }

  static Map<String, dynamic> _defaultMapper(LogRecordEntity record) => {
        'time': record.time.toIso8601String(),
        'level': HemendLogger.loggerLevelMapper(record.level),
        'logger_name': record.loggerName,
        'message': record.message,
        if (record.error != null) 'error': record.error.toString(),
        if (record.stackTrace != null) 'error': record.stackTrace.toString(),
      };
}
