import 'dart:async';

import 'package:hemend_logger/contracts/logger/record.dart';

abstract class ILogPrinter {
  const ILogPrinter();
  int get logLevel;
  bool canRecord(int level) {
    return logLevel <= level;
  }

  FutureOr<void> onRecord(LogRecordEntity record);
}
