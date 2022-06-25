// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetConnected extends InternetState {
  const InternetConnected({
    required this.connectionType,
  });

  final ConnectionType connectionType;
}

class InternetDisconnected extends InternetState {}
