import 'package:hemend_logger/contracts/logger/logger.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_colors.dart';

const _defaultColorMapper = {
  1200: AnsiColor.RED_BOLD,
  1000: AnsiColor.MAGENTA,
  900: AnsiColor.YELLOW_BRIGHT,
  800: AnsiColor.BLUE_BRIGHT,
  700: AnsiColor.WHITE,
  500: AnsiColor.GREEN,
  0: AnsiColor.GREEN_BRIGHT
};

/// ansi(console) log color decorator that uses a map of log-level to [AnsiColor]
/// to print a colored message based on log-level of record
LogDecorator ansiLogMessageColorDecorator({
  Map<int, AnsiColor> colorMap = _defaultColorMapper,
}) {
  return (String message, LogRecordEntity record) {
    final colorWrapper = colorMap.entries
        .where(
          (element) => element.key <= record.level,
        )
        .firstOrNull;
    if (colorWrapper == null) {
      return message;
    } else {
      return colorWrapper.value.wrap(message);
    }
  };
}
