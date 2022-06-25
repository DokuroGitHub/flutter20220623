import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'life_counter_state.dart';

class LifeCounterCubit extends Cubit<LifeCounterState> {
  LifeCounterCubit() : super(const LifeCounterInitial(0));

  void emitLifeCounterLoaded() =>
      emit(LifeCounterLoaded(state.counterValue + 1));
}
