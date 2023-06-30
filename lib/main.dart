import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:multifocus/screens/auth/landing_screen.dart';
import 'package:multifocus/screens/home_screen.dart';
import 'package:multifocus/utils/colors.dart';
import 'package:multifocus/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        color: primary,
        title: 'MultiFocus',
        home: LandingScreen(),
        routes: {
          Routes().homescreen: (context) => const HomeScreen(),
          Routes().landingscreen: (context) => LandingScreen(),
        },
      ),
    );
  }
}
