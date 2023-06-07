// ignore_for_file: comment_references

import 'package:hemend_logger/src/helper/logger_helper.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

/// a mixin that adds logging capabilities to the class
mixin class LogableObject {
  /// this value is only supported in debug mode
  /// for release mode override logger name manually
  /// the reason is that obfuscation method will mess with runtime names
  @mustBeOverridden
  // ignore: no_runtimetype_tostring
  String get loggerName => runtimeType.toString();

  /// [Logger] instance for this class (can be a child of other loggers)
  Logger get logger => Logger(loggerName);

  /// creates a new [Logger] instance that is the child of [logger]
  Logger getChild(String name) => logger.getChild(name);

  /// Log message at level [Level.INFO].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get info => logger.info;

  /// Log message at level [Level.CONFIG].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get config => logger.config;

  /// Log message at level [Level.WARNING].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get warning => logger.warning;

  /// Log message at level [Level.SHOUT].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get shout => logger.shout;

  /// Log message at level [Level.SEVERE].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get severe => logger.severe;

  /// Log message at level [Level.FINEST].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get finest => logger.finest;

  /// Log message at level [Level.FINER].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get finer => logger.finer;

  /// Log message at level [Level.FINE].
  ///
  /// See [Logger.log] for information on how non-String [message] arguments are
  /// handled.
  void Function(
    Object? message, [
    Object? error,
    StackTrace? stackTrace,
  ]) get fine => logger.fine;
}
