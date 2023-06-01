// ignore_for_file: avoid_redundant_argument_values

import 'package:hemend_logger/src/ansi_logger/ansi_style/ansi_color.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_style/ansi_console_style.dart';
import 'package:hemend_logger/src/ansi_logger/ansi_style/ansi_text_effect.dart';
import 'package:hemend_logger/src/contracts/logger/logger.dart';

const _defaultColorMapper = {
  1200: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.red,
        mode: AnsiColorMode.lightForeground,
      ),
    ],
  ),
  1000: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: RgbAnsiColor(
          250,
          100,
          0,
        ),
        mode: AnsiColorMode.foreground,
      ),
    ],
  ),
  900: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.yellow,
        mode: AnsiColorMode.lightForeground,
      ),
    ],
  ),
  800: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.blue,
        mode: AnsiColorMode.lightForeground,
      ),
    ],
  ),
  700: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.white,
      ),
    ],
  ),
  500: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.green,
      ),
    ],
  ),
  400: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.green,
        mode: AnsiColorMode.lightForeground,
      ),
    ],
  ),
  0: AnsiConsoleStyle(
    [
      AnsiColorStyle(
        color: AnsiColor.green,
        mode: AnsiColorMode.lightForeground,
      ),
      AnsiTextEffect.bold,
      AnsiTextEffect.slowBlink,
    ],
  ),
};

/// ansi(console) log color decorator that uses a map of
/// log-level to [AnsiColor] to print a colored message based on
/// log-level of record
///
/// the map must follow the following conditions
///
///
LogDecorator ansiLogMessageColorDecorator({
  Map<int, AnsiConsoleStyle> colorMap = _defaultColorMapper,
}) {
  assert(
    () {
      final items = colorMap.keys.toList();
      for (var index = 1; index < items.length; index++) {
        if (items[index] >= items[index - 1]) {
          return false;
        }
      }
      return true;
    }(),
    'the map keys must be in descending order',
  );
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
