/// {@template ansi-color}
/// this class abstracts how ansi colors are defined
///
/// if you want to know more about ansi colors:
/// https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
/// {@endtemplate}
abstract class IAnsiColor {
  /// the value of the color in ansi escape
  String get value;
}
