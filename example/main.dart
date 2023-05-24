import 'package:hemend_logger/hemend_logger.dart';
import 'package:hemend_logger/src/flow/async_flow.dart';
import 'package:hemend_logger/src/flow/sync_flow.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  HemendLogger.defaultLogger();
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
  final logger = Logger('flow');

  final result = await asyncFlow<int>(
    (defer) async {
      logger.info('now started the flow');
      defer(
        (result) async {
          logger.info('this is first defer, and we will return the 15 as result value');
          return (15, result.exception);
        },
      );

      logger.info('as you can see it will not show defer yet');
      logger.info('now throws an error');
      throw Exception('unknown error');
      defer(
        (p0, exception) async {
          logger.info('but this differ must run first');
          return null;
        },
      );
      return null;
    },
  );
  logger.info(result);
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
    // you can access logger itself by using this property
    config(logger.name);
  }
}
