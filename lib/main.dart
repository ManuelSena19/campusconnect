import 'dart:async';

import 'package:campus_connect/constants/logic.dart';
import 'package:campus_connect/screens/home_screen.dart';
import 'package:campus_connect/screens/login_screen.dart';
import 'package:campus_connect/screens/register_screen.dart';
import 'package:campus_connect/screens/reset_password_screen.dart';
import 'package:campus_connect/screens/verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:campus_connect/constants/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
      } else {}
    });
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
        ? loginRoute
        : homeScreenRoute,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        routes: {
          loginRoute: (context) => const LoginScreen(),
          registerRoute: (context) => const RegisterScreen(),
          homeScreenRoute: (context) => const HomeScreen(),
          verifyEmailRoute: (context) => const VerifyEmailScreen(),
          logicRoute: (context) => const Logic(),
          resetPasswordRoute: (context) => const ResetPasswordScreen(),
        },
        home: const LoginScreen());
  }
}