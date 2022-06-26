import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(const SettingsState(
          appNotification: false,
          emailNotification: false,
        ));

  void toggleAppNotification(bool newValue) =>
      emit(state.copyWith(appNotification: newValue));

  void toggleEmailNotification(bool newValue) =>
      emit(state.copyWith(emailNotification: newValue));
}
