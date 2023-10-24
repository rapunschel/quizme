import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'screens/homepage.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomePage();
        } else {
          return const LoginScreen();
        }
      },
    ));
  }
}
// google sign in



