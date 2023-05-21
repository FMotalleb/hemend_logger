import 'package:hemend_logger/src/hemend_logger.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  HemendLogger.defaultLogger();
  Logger('ExampleLogger')
    ..finest('this is finest with level value:${Level.FINEST.value}')
    ..finer('this is finer with level value:${Level.FINER.value}')
    ..fine('this is fine with level value:${Level.FINE.value}')
    ..config('this is config with level value:${Level.CONFIG.value}')
    ..info('this is info with level value:${Level.INFO.value}')
    ..warning('this is warning with level value:${Level.WARNING.value}')
    ..shout('this is shout with level value:${Level.SHOUT.value}');
}
