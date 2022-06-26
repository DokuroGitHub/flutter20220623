import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    debugPrint(bloc.toString());
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('$bloc, $change');
    super.onChange(bloc, change);
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint(bloc.toString());
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('$bloc, $error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    debugPrint('$bloc, $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    debugPrint('$bloc, $transition');
    super.onTransition(bloc, transition);
  }
}
