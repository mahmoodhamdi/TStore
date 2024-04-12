// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:t_store/core/utils/logging/logger.dart';

class CustomBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    TLoggerHelper.debug('[$bloc] Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    TLoggerHelper.debug('[$bloc] Change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    TLoggerHelper.debug('[$bloc] Transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    TLoggerHelper.error('[$bloc] Error: $error', error);
    TLoggerHelper.error(stackTrace.toString());
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    TLoggerHelper.info('[$bloc] Created');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    TLoggerHelper.info('[$bloc] Closed');
  }
}
