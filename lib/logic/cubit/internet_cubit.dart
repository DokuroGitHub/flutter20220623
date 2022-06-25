import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter20220623/constants/enums.dart';
part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit({required this.connectivity}) : super(InternetInitial()) {
    initConnectivity();
  }

  final Connectivity connectivity;
  late final StreamSubscription connectivityStreamSubscription;

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (event == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (event == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  Future<void> initConnectivity() async {
    try {
      //await connectivity.checkConnectivity();
      connectivityStreamSubscription = monitorInternetConnection();
    } catch (e) {
      debugPrint('Couldn\'t check connectivity status, e: $e');
    }
  }
}
