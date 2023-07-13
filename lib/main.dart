import 'package:calendar_view/calendar_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:multifocus/screens/auth/landing_screen.dart';
import 'package:multifocus/screens/home_screen.dart';
import 'package:multifocus/utils/colors.dart';
import 'package:multifocus/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          authDomain: 'multifocus-f8e35.firebaseapp.com',
          apiKey: "AIzaSyAb3pb918vxH2DZUw09B19sr5V5COpQt5Y",
          appId: "1:445230781387:web:47608be441af1a5db65c4e",
          messagingSenderId: "445230781387",
          projectId: "multifocus-f8e35",
          storageBucket: "multifocus-f8e35.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        color: primary,
        title: 'MultiFocus',
        home: const LandingScreen(),
        routes: {
          Routes().homescreen: (context) => const HomeScreen(),
          Routes().landingscreen: (context) => const LandingScreen(),
        },
      ),
    );
  }
}
