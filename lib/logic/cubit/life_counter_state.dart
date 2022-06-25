part of 'life_counter_cubit.dart';

abstract class LifeCounterState extends Equatable {
  const LifeCounterState(this.counterValue);

  final int counterValue;

  @override
  List<Object> get props => [counterValue];
}

class LifeCounterInitial extends LifeCounterState {
  const LifeCounterInitial(super.counterValue);
}

class LifeCounterLoaded extends LifeCounterState {
  const LifeCounterLoaded(super.counterValue);
}
