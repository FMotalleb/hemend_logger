// ignore_for_file: avoid_print,avoid_redundant_argument_values

import 'package:hemend_logger/hemend_logger.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  HemendLogger.defaultLogger(preferPrintOverLog: true);
  Logger('ExampleLogger')
    ..finest('this is finest with level value:${Level.FINEST.value}')
    ..finer('this is finer with level value:${Level.FINER.value}')
    ..fine('this is fine with level value:${Level.FINE.value}')
    ..config('this is config with level value:${Level.CONFIG.value}')
    ..info('this is info with level value:${Level.INFO.value}')
    ..warning('this is warning with level value:${Level.WARNING.value}')
    ..severe('this is severe with level value:${Level.SEVERE.value}')
    ..shout('this is shout with level value:${Level.SHOUT.value}');
  ExampleClass().test();
  final style = AnsiConsoleStyle([
    AnsiColorStyle(
      color: AnsiColor.fromRgp(
        red: 250,
        green: 150,
      ),
    ),
    AnsiColorStyle(
      color: AnsiColor.fromRgp(
        red: 50,
        green: 50,
        blue: 200,
      ),
      mode: AnsiColorMode.background,
    ),
    AnsiTextEffect.fastBlink,
    AnsiTextEffect.slowBlink,
  ]);
  print(style.wrap('blinking with rgb color and blue bg'));
}

class ExampleClass with LogableObject {
  @override

  /// You should not use toString() here
  /// its only use-case is in debug mode
  /// under production environment this
  /// value is not class name
  // ignore: no_runtimetype_tostring
  String get loggerName => runtimeType.toString();
  void test() {
    finest('this is finest with level value:${Level.FINEST.value}');
    finer('this is finer with level value:${Level.FINER.value}');
    fine('this is fine with level value:${Level.FINE.value}');
    config('this is config with level value:${Level.CONFIG.value}');
    info('this is info with level value:${Level.INFO.value}');
    warning('this is warning with level value:${Level.WARNING.value}');
    shout('this is shout with level value:${Level.SHOUT.value}');
    severe(
      'test error carrier',
      Exception('error happens'),
      StackTrace.current,
    );
    // you can access logger itself by using this property
    config(logger.name);
  }
}
