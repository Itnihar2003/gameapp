

import 'package:coachui/screens/activityinsightspages/previous.dart';
import 'package:coachui/screens/homepage/dashboard.dart';
import 'package:coachui/screens/paymentpages/paymenthistory.dart';
import 'package:coachui/screens/profile/profile.dart';
import 'package:coachui/screens/selectionpages/batchselection.dart';
import 'package:coachui/screens/workoutpages/progress.dart';
import 'package:coachui/screens/workoutpages/workout.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:coachui/screens/onboardingpages/onboarding.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all bindings are initialized properly.
  await Firebase
      .initializeApp(); // Initializes Firebase before running the app.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OnboardingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
