import 'package:hemend_logger/src/contracts/ansi_console/select_graphic_rendition.dart';

/// {@template sgr}
/// you can find more information at https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
/// {@endtemplate}
enum AnsiTextEffect implements ISelectGraphicRendition {
  /// {@macro sgr}
  normal('0'),

  /// {@macro sgr}
  bold('1'),

  /// {@macro sgr}
  dark('2'),

  /// {@macro sgr}
  italic('3'),

  /// {@macro sgr}
  underLine('4'),

  /// {@macro sgr}
  slowBlink('5'),

  /// {@macro sgr}
  fastBlink('6'),

  /// {@macro sgr}
  @Deprecated('Unsupported in most cases')
  swapForegroundAndBackground('8'),

  /// {@macro sgr}
  hidden('8'),

  /// {@macro sgr}
  lineThrough('9'),

  /// {@macro sgr}
  doubleUnderline('21'),

  /// {@macro sgr}
  upperLine('53'),

  /// {@macro sgr}
  superScript('73'),

  /// {@macro sgr}
  subScript('74'),
  ;

  const AnsiTextEffect(this.value);
  @override
  final String value;
  @override
  String get effectiveValue => ISelectGraphicRendition.buildEffectiveValueFrom(
        this,
      );
}
