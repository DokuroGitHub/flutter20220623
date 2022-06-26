// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.appNotification,
    required this.emailNotification,
  });

  final bool appNotification;
  final bool emailNotification;

  @override
  List<Object> get props => [appNotification, emailNotification];

  @override
  String toString() {
    return 'SettingsState(appNotification: $appNotification, emailNotification: $emailNotification)';
  }

  SettingsState copyWith({
    bool? appNotification,
    bool? emailNotification,
  }) {
    return SettingsState(
      appNotification: appNotification ?? this.appNotification,
      emailNotification: emailNotification ?? this.emailNotification,
    );
  }
}
