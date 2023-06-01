// https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters

import 'package:hemend_logger/src/contracts/ansi_console/color.dart';
import 'package:hemend_logger/src/contracts/ansi_console/select_graphic_rendition.dart';

class _RgbAnsiColor implements IAnsiColor {
  _RgbAnsiColor(
    this.red,
    this.green,
    this.blue,
  );

  final int red;
  final int green;
  final int blue;

  @override
  String get value => '8;2;$red;$green;$blue';
}

/// {@macro ansi-color}
enum AnsiColor implements IAnsiColor {
  /// {@macro ansi-color}
  black('0'),

  /// {@macro ansi-color}
  red('1'),

  /// {@macro ansi-color}
  green('2'),

  /// {@macro ansi-color}
  yellow('3'),

  /// {@macro ansi-color}
  blue('4'),

  /// {@macro ansi-color}
  magenta('5'),

  /// {@macro ansi-color}
  cyan('6'),

  /// {@macro ansi-color}
  white('7'),

  /// {@macro ansi-color}
  defaultColor('9'),
  ;

  const AnsiColor(this.value);

  /// creates a SGR parameter that is using 24bit format for colors
  ///
  /// * these color mode does not support
  ///
  /// more documents can be found at https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit
  ///
  /// {@macro ansi-color}
  static IAnsiColor fromRgp({
    int red = 0,
    int green = 0,
    int blue = 0,
  }) =>
      _RgbAnsiColor(
        red,
        green,
        blue,
      );
  @override
  final String value;
}

/// {@macro ansi-color}
enum AnsiColorMode {
  /// {@macro ansi-color}
  foreground('3'),

  /// {@macro ansi-color}
  background('4'),

  /// {@macro ansi-color}
  lightForeground('9'),

  /// {@macro ansi-color}
  lightBackground('10'),
  ;

  const AnsiColorMode(this._value);
  final String _value;
}

/// {@macro ansi-color}
class AnsiColorStyle extends ISelectGraphicRendition {
  /// {@macro ansi-color}
  const AnsiColorStyle({
    this.color = AnsiColor.blue,
    this.mode = AnsiColorMode.foreground,
  }) : assert(
          // ignore: lines_longer_than_80_chars
          color is! _RgbAnsiColor || mode == AnsiColorMode.background || mode == AnsiColorMode.foreground,
          'Rgb Colors does not accept light color modes',
        );

  /// {@macro ansi-color}
  final IAnsiColor color;

  /// {@macro ansi-color}
  final AnsiColorMode mode;

  @override
  String get value => '${mode._value}${color.value}';
}
