// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'counter_cubit.dart';

class CounterState extends Equatable {
  const CounterState({
    required this.counterValue,
    this.wasIncrement,
  });

  factory CounterState.fromJson(String source) =>
      CounterState.fromMap(json.decode(source) as Map<String, dynamic>);

  factory CounterState.fromMap(Map<String, dynamic> map) {
    return CounterState(
      counterValue: map['counterValue'] as int,
      wasIncrement:
          map['wasIncrement'] != null ? map['wasIncrement'] as bool : null,
    );
  }

  final int counterValue;
  final bool? wasIncrement;

  @override
  List<Object?> get props => [counterValue, wasIncrement];

  @override
  String toString() =>
      'CounterState(counterValue: $counterValue, wasIncrement: $wasIncrement)';

  CounterState copyWith({
    int? counterValue,
    bool? wasIncrement,
  }) {
    return CounterState(
      counterValue: counterValue ?? this.counterValue,
      wasIncrement: wasIncrement ?? this.wasIncrement,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'counterValue': counterValue,
      'wasIncrement': wasIncrement,
    };
  }

  String toJson() => json.encode(toMap());
}
