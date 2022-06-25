import 'package:bloc_test/bloc_test.dart';
import 'package:flutter20220623/logic/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    late CounterCubit counterCubit;

    // ~ init
    setUp(() {
      counterCubit = CounterCubit();
    });

    // ~ dispose
    tearDown(() {
      counterCubit.close();
    });

    test(
        'the initial value of counterCubit.state is CounterState(counterValue: 0)',
        () {
      expect(counterCubit.state, const CounterState(counterValue: 0));
    });

    blocTest<CounterCubit, CounterState>(
      '''the cubit should emit a CoutnerState(counterValue:1, wasIncrement:true) 
      when cubit.increment() function is called''',
      build: () => counterCubit,
      act: (cubit) => cubit.increment(),
      expect: () => [const CounterState(counterValue: 1, wasIncrement: true)],
    );

    blocTest<CounterCubit, CounterState>(
      '''the cubit should emit a CoutnerState(counterValue:1, wasIncrement:false) 
      when cubit.decrement() function is called''',
      build: () => counterCubit,
      act: (cubit) => cubit.decrement(),
      expect: () => [const CounterState(counterValue: -1, wasIncrement: false)],
    );
  });
}
