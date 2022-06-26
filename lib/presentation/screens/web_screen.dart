// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter20220623/presentation/widgets/landing_page/landing_page.dart';
import 'package:flutter20220623/presentation/widgets/nav_bar/nav_bar.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);

  final Color color;
  final String title;

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(195, 20, 50, 1.0),
              Color.fromRGBO(36, 11, 54, 1.0),
            ]),
          ),
          child: Column(children: const [
            NavBar(),
            LandingPage(),
          ]),
        ),
      ),
    );
  }
}
