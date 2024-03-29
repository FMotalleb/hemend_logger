// ignore_for_file: avoid_positional_boolean_parameters, avoid_redundant_argument_values, lines_longer_than_80_chars

import 'dart:async';

import 'package:hemend_logger/hemend_logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'hemend_logger_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<ILogRecorder>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<LogRecordEntity>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
    MockSpec<Logger>(
      onMissingStub: OnMissingStub.returnDefault,
    ),
  ],
)
void main() {
  group(
    'HemendLogger',
    () {
      late HemendLogger loggerInstance;
      late MockILogRecorder Function(bool canRecord) testLogRecorderBuilder;
      late Logger logger;
      late LogRecordEntity logEntity;
      setUp(() {
        logger = Logger.root;
        testLogRecorderBuilder = ([canRecord = true]) {
          final instance = MockILogRecorder();
          when(instance.canRecord(any)).thenReturn(canRecord);
          when(instance.close()).thenReturn(null);
          if (canRecord) {
            when(instance.onRecord(any)).thenReturn(null);
          } else {
            when(instance.onRecord(any)).thenThrow(
              Exception(
                'Cannot log with this logger',
              ),
            );
          }
          return instance;
        };
        loggerInstance = HemendLogger(
          logger: logger,
        );
        logEntity = LogRecordEntity(
          error: null,
          level: 800,
          loggerName: '',
          message: 'test',
          stackTrace: null,
          time: DateTime.now(),
          zone: null,
        );
      });
      test(
        'Manger Initialization',
        () {
          final noPrint = ZoneSpecification(
            print: (self, parent, zone, line) {},
          );
          runZoned(
            () {
              expect(loggerInstance.logLevel, logger.level.value);

              final testLogger = Logger('non.root.logger');
              expect(
                () {
                  HemendLogger(logger: testLogger);
                },
                throwsException,
              );
              var defaultLogger = HemendLogger.defaultLogger(
                logger: testLogger,
                preferPrintOverLog: true,
              );
              expect(defaultLogger, isA<HemendLogger>());
              testLogger.info(
                'test',
                Exception('test error'),
                StackTrace.empty,
              );
              expect(defaultLogger.listeners.isEmpty, false);
              defaultLogger.removeListener(defaultLogger.listeners.first);
              expect(defaultLogger.listeners.isEmpty, true);
              defaultLogger = HemendLogger.defaultLogger(
                preferPrintOverLog: false,
              );
              expect(defaultLogger, isA<HemendLogger>());
              Logger.root.info(
                'test',
                Exception('test error'),
                StackTrace.empty,
              );
              expect(defaultLogger.listeners.isEmpty, false);
              defaultLogger.removeListener(defaultLogger.listeners.first);
              expect(defaultLogger.listeners.isEmpty, true);

              var jsonLogger = HemendLogger.jsonLogger(
                logger: testLogger,
              );
              expect(jsonLogger, isA<HemendLogger>());
              testLogger.info(
                'test',
                Exception('test error'),
                StackTrace.empty,
              );
              expect(jsonLogger.listeners.isEmpty, false);
              jsonLogger.removeListener(jsonLogger.listeners.first);
              expect(jsonLogger.listeners.isEmpty, true);
              jsonLogger = HemendLogger.jsonLogger();
              expect(jsonLogger, isA<HemendLogger>());
              Logger.root.info(
                'test',
                Exception('test error'),
                StackTrace.empty,
              );
              expect(jsonLogger.listeners.isEmpty, false);
              jsonLogger.removeListener(jsonLogger.listeners.first);
              expect(jsonLogger.listeners.isEmpty, true);
            },
            zoneSpecification: noPrint,
          );
        },
      );
      test(
        'Test Manger Capture',
        () async {
          final recorder = testLogRecorderBuilder(true);
          loggerInstance.addListener(recorder);
          logger.info('test');
          await untilCalled(recorder.onRecord(any));
          verify(recorder.canRecord(any)).called(1);
          verify(recorder.onRecord(any)).called(1);
        },
      );
      test(
        'Test Add/Remove Recorder',
        () {
          final instance = testLogRecorderBuilder(true);
          loggerInstance.addListener(instance);
          final hasLogRecorder = loggerInstance.listeners.contains(instance);
          expect(
            hasLogRecorder,
            true,
          );
          loggerInstance.removeListener(instance);
          final hasLogRecorder2 = loggerInstance.listeners.contains(instance);
          expect(
            hasLogRecorder2,
            false,
          );
          verify(instance.close()).called(1);
        },
      );
      test(
        'Test Log Recording',
        () {
          final recorder = testLogRecorderBuilder(true);
          final notRecorder = testLogRecorderBuilder(false);

          loggerInstance
            ..addListener(recorder)
            ..addListener(notRecorder)
            ..onLog(logEntity);

          verify(recorder.canRecord(logEntity)).called(1);
          verify(notRecorder.canRecord(logEntity)).called(1);
          verify(recorder.onRecord(logEntity)).called(1);
          verifyNever(notRecorder.onRecord(logEntity)).called(0);
        },
      );
    },
  );
}
