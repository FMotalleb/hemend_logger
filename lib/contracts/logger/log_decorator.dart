part of 'logger.dart';

/// [LogDecorator] abstraction indicates that any decorator will receive
/// last non-decorated or decorated message from [ILogRecorder]
/// and decorate it with given record then return a decorated message
typedef LogDecorator = String Function(String message, LogRecordEntity record);

/// mixin for [ILogRecorder] to add a [decorate] method
/// that decorates messages using [decoration]
mixin DecoratedPrinter on ILogRecorder {
  /// {@template log-decoration}
  /// List of decorators that are used by this [ILogRecorder].
  ///
  /// please make sure that you have inserted decorators in correct order
  /// {@endtemplate}
  List<LogDecorator> get decoration;

  /// a method that receives the non-decorated message from the [ILogRecorder]
  /// and decorates it with [decoration]
  String decorate(String message, LogRecordEntity record) {
    final output = decoration.fold(
      message,
      (previousValue, element) => element(previousValue, record),
    );
    return output;
  }
}
