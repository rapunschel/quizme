import 'package:quizme/auth.dart';
import 'package:quizme/firebase_options.dart';
import 'package:quizme/screens/home_screen.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:quizme/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const Auth(),
        'homeScreen': (context) => HomePage(), //const HomeScreen(),
        'loginScreen': (context) => const LoginScreen(),
        'signupScreen': (context) => const SignupScreen(),
      },
    );
  }
}
