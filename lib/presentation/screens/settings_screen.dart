import 'package:flutter/material.dart';
import 'package:flutter20220623/logic/cubit/settings_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<SettingsCubit, SettingsState>(
        listener: ((context, state) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'App ${state.appNotification.toString().toUpperCase()}, Email ${state.emailNotification.toString().toUpperCase()}',
                style: const TextStyle(color: Colors.green),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }),
        child: BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
          debugPrint('App Notification, Email Notification');
          return Column(
            children: [
              SwitchListTile(
                value: state.appNotification,
                onChanged: (value) {
                  context.read<SettingsCubit>().toggleAppNotification(value);
                },
                title: const Text('App Notification'),
              ),
              SwitchListTile(
                value: state.emailNotification,
                onChanged: (value) {
                  context.read<SettingsCubit>().toggleEmailNotification(value);
                },
                title: const Text('Email Notification'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
