import 'package:flutter/material.dart';
import 'package:flutter20220623/presentation/screens/home_screen.dart';
import 'package:flutter20220623/presentation/screens/second_screen.dart';
import 'package:flutter20220623/presentation/screens/settings_screen.dart';
import 'package:flutter20220623/presentation/screens/third_screen.dart';
import 'package:flutter20220623/presentation/screens/web_screen.dart';

class AppRouter {
  Route onGenrateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(
            title: 'HomeScreen',
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => const SecondScreen(
            title: 'SecondScreen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => const ThirdScreen(
            title: 'ThirdScreen',
            color: Colors.greenAccent,
          ),
        );
      case '/web':
        return MaterialPageRoute(
          builder: (_) => const WebScreen(
            title: 'WebScreen',
            color: Colors.grey,
          ),
        );
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Error page'),
              backgroundColor: Colors.redAccent,
            ),
            body: const Center(child: Text('Some thing went wrong')),
          ),
        );
    }
  }
}
