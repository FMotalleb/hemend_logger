import 'package:hemend_logger/src/flow/helper.dart';
import 'package:hemend_logger/src/flow/sync_flow.dart';

/// {@template a-result-signature}
/// The result signature refers to the shape or structure of the object that will
///  be returned from the handler in a specific context. It serves as a container
///   for the last result obtained from deferred methods and also holds
///  information about the most recent exception that was thrown within
///  the handler.
///
/// The purpose of the result signature is to encapsulate the outcome of
/// the handler's execution, allowing for the transmission of relevant data and
/// error information. By defining a standardized structure for the result
/// signature, it becomes easier to handle and process the returned object
/// consistently across different components or modules within a system.
///
/// In practice, the result signature typically includes fields or properties
/// that represent the result of the handler's operation and any relevant
/// metadata associated with it. This can include, for example, the success or
/// failure status of the operation, the actual result or output produced, and
/// any additional contextual information or error messages.
///
/// By utilizing a well-defined result signature, developers can establish clear
/// expectations regarding the structure and content of the returned object,
/// enabling better interoperability and error handling in the overall system.
/// This approach promotes code reusability, maintainability, and enhances the
/// overall robustness of the system by providing a standardized interface for
/// communicating the outcome of the handler's execution.
/// {@endtemplate}
typedef AsyncResultSignature<T> = Future<ResultSignature<T>?>;

/// {@template a-deferred-callback}
/// The concept of a deferred callback outlines the behavior and functionality
/// of a method that is executed after a previous deferred operation or
/// the main method itself has completed. This callback method receives
/// the result and/or exception from the preceding deferred operation or
/// the main method and performs specific actions based on this information.
/// It also has the capability to modify the flow's result, depending on
/// the requirements.
///
/// The AsyncDeferred type defines the signature of a deferred callback method.
/// It takes a ResultSignature<T> as input, representing the result and
/// exception from the previous deferred operation or the main method.
/// The callback method can then process this input and return
/// an AsyncResultSignature<T> object or null if no further modifications or
/// actions are necessary.
///
/// The purpose of the deferred callback is to provide a mechanism for handling
/// and reacting to the result or exception of a preceding deferred operation.
/// This allows for additional logic or modifications to be applied before
/// passing the control flow to subsequent steps. The callback method can access
/// and analyze the result and exception data, enabling it to make informed
/// decisions or perform specific operations based on the outcome.
///
/// By utilizing deferred callbacks, developers can introduce dynamic behavior
/// and flexible control flow in asynchronous programming scenarios. The ability
/// to modify the flow's result empowers developers to implement custom error
/// handling, logging, retries, or other post-processing tasks based on
/// the context and requirements of the application.
///
/// Overall, the concept of a deferred callback enhances the extensibility and
/// flexibility of asynchronous programming paradigms by allowing developers to
/// define and control the behavior of methods that follow deferred operations
/// or the main execution flow.
/// {@endtemplate}
typedef AsyncDeferred<T> = AsyncResultSignature<T>? Function(
  ResultSignature<T>,
);

/// {@template a-task}
/// The concept of a task flow describes the behavior and functionality of an
/// asynchronous method that executes a series of operations in a specific order
/// . The AsyncTask type defines the signature of such a task flow method.
/// It takes a void Function(AsyncDeferred<T>) defer parameter, which enables
/// the method to schedule and execute deferred methods after completing its own
/// tasks.
///
/// Within the task flow method, developers can define the sequence of
/// operations to be performed asynchronously. This can include any combination
/// of computations, I/O operations, or network requests. The task flow method
/// takes control of the execution and ensures that each operation is executed
/// in the defined order.
///
/// The defer function, provided as a parameter to the task flow method, serves
/// as a mechanism to schedule deferred methods. These deferred methods are
/// executed after the task flow method has completed its own tasks. By invoking
/// the defer function and passing an AsyncDeferred<T> callback, developers can
/// schedule additional operations or callbacks to be executed in the subsequent
/// steps of the task flow.
///
/// The purpose of the task flow is to enable developers to orchestrate and
/// control the execution of asynchronous operations in a structured manner.
/// By defining a clear sequence of tasks and utilizing deferred methods,
/// developers can ensure that each operation is executed at the appropriate
/// time and with the necessary dependencies. This promotes maintainability,
/// readability, and better error handling in asynchronous programming scenarios
///
/// In summary, the concept of a task flow provides a structured approach to
/// organizing and executing asynchronous operations. By defining the order of
/// tasks and utilizing the defer function to schedule deferred methods,
/// developers can create more robust and maintainable asynchronous workflows.
/// {@endtemplate}
typedef AsyncTask<T> = AsyncResultSignature<T>? Function(
  void Function(AsyncDeferred<T>) defer,
);

/// The provided code snippet presents a simple helper method designed to
/// facilitate the usage of a flow handler. This helper method, named asyncFlow,
/// takes an AsyncTask<T> as a parameter and returns an AsyncResultSignature<T>
/// object.
///
/// The purpose of this helper method is to streamline the usage of
/// the flow handler by abstracting away the details of handling and executing
/// the asynchronous task flow. By encapsulating the interaction with
/// the flow handler within the asyncFlow method, developers can utilize a more
/// concise and straightforward syntax.
///
/// Internally, the asyncFlow method utilizes the AsyncFlow.handle<T> method
/// from the AsyncFlow class to execute the provided task.
/// The AsyncFlow.handle<T> method takes the AsyncTask<T> as input and
/// orchestrates the execution of the task flow, managing the scheduling of
/// deferred methods and handling the flow's result.
///
/// By leveraging the asyncFlow helper method, developers can avoid direct
/// interactions with the flow handler and benefit from a more streamlined and
/// readable code structure. The asyncFlow method encapsulates the complexities
/// of the flow handler and provides a simplified interface for utilizing
/// asynchronous task flows.
AsyncResultSignature<T>? asyncFlow<T>(
  AsyncTask<T> task,
) =>
    AsyncFlow.handle<T>(task);

/// Async Flow Handler will create an additional call stack to push desired
/// methods to run after the main call
class AsyncFlow<T> {
  AsyncFlow._()
      : _differedStack = [],
        _isDone = false;

  /// This static method serves as the entry point to the AsyncFlow handler.
  /// It receives an [AsyncTask] and executes it within a try scope.
  /// It returns a AsyncResultSignature<T> object, which consists of a result
  /// and an exception.
  ///
  /// The task parameter represents the main method to be executed in
  /// the task flow. Within this method, you can use
  /// the defer method (accessible as a parameter) to push methods to run after
  /// the main method call.
  ///
  /// The defer method receives the result and/or exception from
  /// the last deferred method or the main method. It can act on
  /// these values and may or may not modify the result of the flow.
  static AsyncResultSignature<T> handle<T>(
    AsyncTask<T> task,
  ) =>
      AsyncFlow<T>._()._deferredCall(task);
  final List<AsyncDeferred<T>> _differedStack;
  bool _isDone;
  void _pushToDiffer(AsyncDeferred<T> task) => _differedStack.add(task);

  AsyncResultSignature<T> _deferredCall(
    AsyncTask<T> task,
  ) async {
    if (_isDone) {
      throw Exception('This Flow is already completed');
    }
    ResultSignature<T> result = (result: null, exception: null);
    try {
      result = await task(_pushToDiffer) ?? result;
    } catch (e) {
      result = (result: null, exception: e);
    }

    _isDone = true;
    return _differedStack.reversed.fold<Future<ResultSignature<T>>>(
      Future.value(result),
      (previousValue, element) async {
        final prevResult = await previousValue;
        final result = await element(prevResult);
        return prevResult.copyWith(
          result: result?.result,
          exception: result?.exception,
        );
      },
    );
  }
}
