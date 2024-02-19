import 'package:logging/logging.dart';

/// an extension set on [Logger]
extension LoggerTools on Logger {
  /// creates a child for logger
  ///
  /// if current logger:
  /// * is named will return a named Logger('[fullName].[name]')
  /// * is root logger then it will return a named Logger('[name]')
  /// * is detached this method will throw an exception
  @Deprecated('Use [newChildLogger] instead of this')
  Logger Function(String) get getChild => newChildLogger;

  /// creates a child for logger
  ///
  /// if current logger:
  /// * is named will return a named Logger('[fullName].[name]')
  /// * is root logger then it will return a named Logger('[name]')
  /// * is detached this method will throw an exception
  Logger newChildLogger(String name) {
    if (fullName.isEmpty) {
      return Logger(name);
    } else if (parent == null) {
      throw Exception('Detached Loggers cannot have any children');
    }
    return Logger('$fullName.$name');
  }
}
