import 'package:hemend_logger/contracts/logger/log_printer.dart';
import 'package:hemend_logger/contracts/logger/record.dart';

typedef LogDecorator = String Function(String message, LogRecordEntity record);

mixin DecoratedPrinter on ILogPrinter {
  List<LogDecorator> get decoration;
  String decorate(String message, LogRecordEntity record) {
    final output = decoration.fold(
      message,
      (previousValue, element) => element(previousValue, record),
    );

    return output;
  }
}
