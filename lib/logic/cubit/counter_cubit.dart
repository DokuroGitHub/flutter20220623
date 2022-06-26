import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit()
      : super(const CounterState(counterValue: 0, wasIncrement: null));

  // HyndratedBloc
  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toMap();
  }

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncrement: true));

  void decrement() => emit(
      CounterState(counterValue: state.counterValue - 1, wasIncrement: false));
}
