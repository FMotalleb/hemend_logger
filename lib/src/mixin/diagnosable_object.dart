import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

/// Objects with this mixin are able to use logger functions easier
/// it introduces [logger] as the object's logging interface and
/// provides useful logger methods into the object like
/// [info],[config],[warning] and etc.
mixin DiagnosableObject {
  /// this value is only supported in debug mode
  /// for release mode override logger name manually
  /// the reason is that obfuscation method will mess with runtime names
  @mustBeOverridden
  String get loggerName => runtimeType.toString();

  Logger get logger => Logger(loggerName);
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get info => logger.info;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get config => logger.config;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get warning => logger.warning;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get shout => logger.shout;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get severe => logger.severe;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get finest => logger.finest;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get finer => logger.finer;
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get fine => logger.fine;
}
