/// {@template select-graphic-rendition}
/// this class abstracts how a single SelectGraphicRendition is defined
///
/// for more information https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_(Select_Graphic_Rendition)_parameters
/// {@endtemplate}
abstract class ISelectGraphicRendition {
  /// {@macro select-graphic-rendition}
  const ISelectGraphicRendition();

  /// every SGR must carry a display attribute
  String get value;
  static const String _preQuery = '\x1B[';
  static const String _postQuery = 'm';

  /// real ansi-escape value of SGR
  String get effectiveValue => buildEffectiveValueFrom(this);

  /// this method creates ansi-escape from a SGI
  ///
  /// simply by wrapping it with \x1B[`<Value>`m
  static String buildEffectiveValueFrom(ISelectGraphicRendition sgr) {
    final buffer = StringBuffer(_preQuery)
      ..write(sgr.value)
      ..write(_postQuery);
    return buffer.toString();
  }
}
