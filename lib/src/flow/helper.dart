import 'package:hemend_logger/src/flow/sync_flow.dart';

/// helper extension for [ResultSignature] record
extension SignatureHelper<T> on ResultSignature<T> {
  /// The copyWith method is used to create a new record with updated result and
  /// exception values. It receives an optional T as the new result value and
  /// an optional Object as the exception value. It returns a new
  /// [ResultSignature] object.
  ///
  /// The copyWith method replaces non-null result and/or exception values over
  /// the current this.result and/or this.exception values. If either result or
  /// exception is null, it returns the current values from the source
  /// [ResultSignature].
  ///
  /// Example usage:
  /// ```dart
  /// final originalResult = ResultSignature<int>(result: 5, exception: null);
  /// final newResult = originalResult.copyWith(result: 10);
  ///  // newResult will have result: 10 and exception: null
  /// final originalResult2 = ResultSignature<String>(result: null, exception: Exception('Error'));
  /// final newResult2 = originalResult2.copyWith(exception: null);
  /// // newResult2 will have result: null and exception: Exception('Error')
  /// ```
  ResultSignature<T> copyWith({T? result, Object? exception}) {
    return (
      result: result ?? this.result,
      exception: exception ?? this.exception,
    );
  }
}
