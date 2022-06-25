// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

class CounterState extends Equatable {
  const CounterState({
    required this.counterValue,
    this.wasIncrement,
  });

  final int counterValue;
  final bool? wasIncrement;

  @override
  List<Object?> get props => [counterValue, wasIncrement];
}
