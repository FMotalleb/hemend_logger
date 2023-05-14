import 'dart:async';

class LogRecordEntity {
  LogRecordEntity({
    required this.error,
    required this.level,
    required this.loggerName,
    required this.message,
    required this.stackTrace,
    required this.time,
    required this.zone,
  });

  final Object? error;

  final int level;

  final String loggerName;

  final String message;

  final StackTrace? stackTrace;

  final DateTime time;

  final Zone? zone;
}
