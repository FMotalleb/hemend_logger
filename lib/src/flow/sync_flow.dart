import 'package:hemend_logger/src/flow/helper.dart';

/// {@template result-signature}
/// The `ResultSignature` represents the structure of the object that will be
/// returned from the handler. It contains information about the last result
/// obtained from deferred methods and the most recent exception thrown within
/// the handler.
///
/// The purpose of the `ResultSignature` is to encapsulate the outcome of
/// the handler's execution in a standardized format. It provides a container
/// for the last result obtained from deferred methods, allowing subsequent
/// operations to access and utilize this result. Additionally, it captures
/// the latest exception thrown within the handler, enabling appropriate error
/// handling and reporting.
///
/// The `ResultSignature` typically includes two components:
///
/// 1. `result`: This field holds the last result obtained from deferred methods
/// or the main method itself. It represents the outcome or output of
/// the handler's execution. The type of the `result` can vary based on
/// the specific implementation or context.
///
/// 2. `exception`: This field contains the most recent exception thrown within
/// the handler, if any. It captures any errors or exceptional conditions
/// that occurred during the execution of the handler. The `exception` can be of
/// type `Exception`, `Error`, or any other relevant exception type.
///
/// By using the `ResultSignature` object, developers can pass along the last
/// result and exception information to subsequent components or modules for
/// further processing or handling. This promotes transparency, traceability,
/// and effective error management within the handler's execution flow.
/// {@endtemplate}
typedef ResultSignature<T> = ({T? result, Object? exception});

/// {@template deferred-callback}
/// The concept of a synchronous deferred method defines the behavior and
/// functionality of a method that is scheduled to run synchronously after
/// the completion of a preceding deferred method or the main method itself.
///
/// Synchronous deferred methods receive the result and/or exception from
/// the previous deferred method or the main method as parameters.
/// These inputs provide contextual information that
/// the synchronous deferred method can utilize to make decisions or
/// perform actions. The method can act on the received result and/or exception
/// and has the option to modify the result of the overall flow.
///
/// Similar to asynchronous deferred methods, synchronous deferred methods can
/// perform various tasks based on the received inputs. They may handle errors,
/// perform data transformations, or execute any other relevant operations.
///
/// Synchronous deferred methods provide an opportunity to implement custom
/// logic and fine-tune the behavior of the synchronous task flow.
/// By receiving and acting upon the result and/or exception from preceding
/// steps, developers can create synchronous task flows that are adaptable
/// and customizable to meet specific requirements.
/// {@endtemplate}
typedef SyncDeferred<T> = ResultSignature<T>? Function(ResultSignature<T>?);

/// {@template task}
/// The SyncTask type defines the behavior and structure of a synchronous
/// task flow. It represents a method that will be executed synchronously and
/// receives a defer method from the flow handler as a parameter.
/// The defer method can be used to push a synchronous deferred method to run
/// after the execution of the current task.

/// Within the SyncTask method, developers have the ability to utilize the defer
/// method to schedule and define subsequent synchronous deferred methods.
/// These deferred methods will run after the completion of the current task.
/// They can receive and act upon the result and/or exception from the previous
/// deferred method or the main method, allowing for custom actions and
/// potential modification of the overall result.

/// By leveraging the defer method and synchronous deferred methods, developers
/// can orchestrate a synchronous task flow with specific behaviors and
/// sequential execution. Each task can perform its designated operations and
/// utilize the defer method to schedule subsequent steps.
/// {@endtemplate}
typedef SyncTask<T> = ResultSignature<T>? Function(
  void Function(SyncDeferred<T>) defer,
);

/// This helper method simplifies the usage of the sync flow handler
/// by encapsulating the execution logic and returning the result as a
/// ResultSignature object.
///
/// Developers can easily integrate this method into their code to streamline
/// the implementation of synchronous task flows with the flow handler.
ResultSignature<T>? syncFlow<T>(
  SyncTask<T> task,
) =>
    SyncFlowHandler.handle<T>(task);

/// The SyncFlowHandler is responsible for managing synchronous task flows by
/// creating an additional call stack to schedule and execute desired methods
/// after the main call. It provides a structured and organized approach to
/// handle sequential execution of synchronous tasks.
///
/// By utilizing the Sync Flow Handler, developers can easily define and
/// orchestrate the execution order of synchronous methods, allowing for
/// modular and customizable synchronous task flows.
/// The handler creates a separate call stack for deferred methods, enabling
/// them to run in a controlled and predetermined sequence, ensuring proper
/// flow and synchronization within the task execution.
/// This abstraction simplifies the implementation of complex synchronous flows,
/// enhances code readability, and promotes maintainability by separating
/// the flow control logic from the actual task implementations.
///
/// Overall, the Sync Flow Handler serves as a valuable tool in managing
/// synchronous task flows and enables developers to design efficient
/// and well-structured synchronous execution paths.
class SyncFlowHandler<T> {
  SyncFlowHandler._()
      : _differedStack = [],
        _isDone = false;

  /// entry point to the SyncFlowHandler
  ///
  /// will receive a [SyncTask] and call it in a try scope
  /// and returns a Record of ([T]? result, [Object]? exception)
  ///
  /// you can use `defer` method (accessible in the [SyncTask] as parameter)
  /// to push methods to run after the main method call
  ///
  /// defer method will receive result and|or exception from last deferred
  /// or the main method itself and act on them then they may or may not modify
  /// the result of the flow
  static ResultSignature<T>? handle<T>(
    SyncTask<T> task,
  ) =>
      SyncFlowHandler<T>._()._deferredCall(task);
  final List<SyncDeferred<T>> _differedStack;
  bool _isDone;
  void _pushToDiffer(SyncDeferred<T> task) => _differedStack.add(task);

  ResultSignature<T>? _deferredCall(
    SyncTask<T> task,
  ) {
    if (_isDone) {
      throw Exception('This Flow is already completed');
    }
    ResultSignature<T>? result = (result: null, exception: null);
    try {
      result = task(_pushToDiffer) ?? result;
    } catch (e) {
      result = (result: null, exception: e);
    }

    _isDone = true;
    return _differedStack.reversed.fold<ResultSignature<T>?>(
      result,
      (previousValue, element) {
        final deferResult = element(previousValue);
        return previousValue?.copyWith(
          result: deferResult?.result,
          exception: deferResult?.exception,
        );
      },
    );
  }
}
