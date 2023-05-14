import 'dart:developer';

import 'package:hemend_logger/contracts/logger/log_decorator.dart';
import 'package:hemend_logger/contracts/logger/log_printer.dart';
import 'package:hemend_logger/contracts/logger/record.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_color.dart';

class AnsiLogger extends ILogPrinter with DecoratedPrinter {
  AnsiLogger({
    required this.logLevel,
    this.recordAdapter,
    this.decoration = const [],
    this.levelToColorMapper = AnsiLogger.defaultColorMapper,
  }) : assert(
          levelToColorMapper[0] != null || recordAdapter != null,
          '''always create a level to color mapper for level 0 otherwise logger will probably fail when trying to find a color mapper for low level logs''',
        );

  // from [Level] of package logging
  static const defaultColorMapper = {
    1200: AnsiColors.RED_BOLD,
    1000: AnsiColors.MAGENTA,
    900: AnsiColors.YELLOW_BRIGHT,
    800: AnsiColors.BLUE_BRIGHT,
    700: AnsiColors.WHITE,
    500: AnsiColors.GREEN,
    0: AnsiColors.GREEN_BRIGHT
  };
  @override
  List<LogDecorator> decoration;
  final Map<int, AnsiColors> levelToColorMapper;
  final String Function(LogRecordEntity)? recordAdapter;

  @override
  final int logLevel;

  @override
  void onRecord(LogRecordEntity record) {
    final message = _logFormatter(record);
    log(
      message,
      level: record.level,
      name: record.loggerName,
      error: record.error,
      stackTrace: record.stackTrace,
      time: record.time,
      zone: record.zone,
    );
  }

  String _logFormatter(LogRecordEntity record) {
    final String message;
    final String formattedMessage;
    if (recordAdapter == null) {
      message = record.message;
      final mapper = levelToColorMapper.entries.firstWhere(
        (element) => record.level >= element.key,
      );
      formattedMessage = mapper.value.wrap(message);
    } else {
      formattedMessage = recordAdapter!(record);
    }

    return decorate(formattedMessage, record);
  }
}
