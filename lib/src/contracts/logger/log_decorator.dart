part of 'logger.dart';

/// The decorator function then applies the necessary modifications or
/// enhancements to the log message and returns the decorated message as a
/// String. This allows for customizing the formatting, adding contextual
/// information, or performing any other desired
/// transformations on log messages.
typedef LogDecorator = String Function(String message, LogRecordEntity record);

/// The [DecoratedPrinter] mixin extends the functionality of
/// the [ILogRecorder] interface by adding a [decorate] method.
///
/// This mixin is designed to be used with classes that implement
/// the [ILogRecorder] interface.
///
/// The purpose of the [DecoratedPrinter] mixin is to enable the [decoration] of
/// log messages using a list of decorators specified by
/// the [decoration] property.
mixin DecoratedPrinter on ILogRecorder {
  /// {@template log-decoration}
  /// returns a list of [LogDecorator] functions.
  ///
  /// These [LogDecorator] functions represent the decorators that will be
  /// applied to log messages.
  ///
  /// It is important to ensure that the decorators are inserted in the correct
  /// order to achieve the desired decoration effect.
  /// {@endtemplate}
  List<LogDecorator> get decoration;

  /// The decorate method is a method that receives a non-decorated log message
  /// as [message] and a [LogRecordEntity] object as record.
  /// It applies the decoration logic using the list of [LogDecorator]
  /// functions specified in the [decoration] property.
  ///
  /// Here's how the decorate method works:
  ///
  /// 1. It starts with the [message] parameter as the initial value.
  /// 2. It uses the fold method on the [decoration] list to iterate over each
  /// [LogDecorator] function.
  /// 3. In each iteration, the current [LogDecorator] function is invoked with
  /// the previousValue (initially set to the message) and the record.
  /// 4. The result of each decorator invocation becomes the previousValue for
  /// the next iteration.
  /// 5. Finally, the decorated message is returned as the output of
  /// the decorate method.
  /// This approach allows for a sequential application of decorators,
  /// where each decorator modifies the log message based on the previous
  /// decorator's output.
  /// The end result is a decorated message that has been processed by all
  /// the decorators in the [decoration] list.
  ///
  /// Implementing the [decorate] method in this way provides a convenient and
  /// flexible mechanism to decorate log messages before they are recorded by
  /// the log recorder's main method.
  String decorate(String message, LogRecordEntity record) {
    final output = decoration.fold(
      message,
      (previousValue, element) => element(previousValue, record),
    );
    return output;
  }
}
