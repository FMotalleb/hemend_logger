import 'package:hemend_logger/src/contracts/ansi_console/select_graphic_rendition.dart';

/// {@template ansi-console-style}
/// This is a wrapper around multiple [ISelectGraphicRendition]s
/// that will combine them into one [ISelectGraphicRendition].
///
/// Remember, the stack of styles is different from what you might assume.
///
/// Latter effects will not override former effects,
/// but they may mix with each other, such as background color,
/// foreground color, blinking,
/// and underline.
///
/// However, fast blink and slow blink will not mix.
/// The first effect will be accepted and displayed.
///
/// This mechanism is not handled in this package and will be handled by
/// the console itself.
/// {@endtemplate}
class AnsiConsoleStyle extends ISelectGraphicRendition {
  /// {@macro ansi-console-style}
  const AnsiConsoleStyle(
    this.selectGraphicRenditions,
  );

  /// Select Graphic Rendition that are mixed together
  final List<ISelectGraphicRendition> selectGraphicRenditions;
  @override
  String get value => throw Exception('Cannot get value of a mixed style');
  @override
  String get effectiveValue => selectGraphicRenditions
      .fold(
        StringBuffer(),
        (previousValue, element) => previousValue
          ..write(
            element.effectiveValue,
          ),
      )
      .toString();
  static const ISelectGraphicRendition _reset = _ResetEffects();

  /// {@template wrap-style}
  /// this method receives a [String] [input] and wraps it with SGRs
  /// from [selectGraphicRenditions] and returns a message that can be
  /// written in an ansi terminal
  /// {@endtemplate}
  String wrap(String input) {
    final buffer = StringBuffer();
    if (selectGraphicRenditions.isNotEmpty) {
      buffer
        ..write(effectiveValue)
        ..write(input)
        ..write(_reset.effectiveValue);
      return buffer.toString();
    } else {
      return input;
    }
  }

  /// {@macro wrap-style}
  String call(String input) => wrap(input);
}

class _ResetEffects extends ISelectGraphicRendition {
  const _ResetEffects();
  @override
  String get value => '0;0';
}
