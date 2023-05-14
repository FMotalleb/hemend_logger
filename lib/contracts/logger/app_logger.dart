import 'package:hemend_logger/contracts/logger/log_printer.dart';
import 'package:hemend_logger/contracts/logger/record.dart';

abstract class ILogManager {
  List<ILogPrinter> get listeners;
  int get logLevel;
  void init();
  Future<void> onLog(LogRecordEntity record);
  void addListener(ILogPrinter listener);
  void removeListener(ILogPrinter listener);
}
