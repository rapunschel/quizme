import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizme/screens/forgot_password_page.dart';
import 'providers/play_quiz_provider.dart';
import 'providers/quiz_handler.dart';
import 'screens/home_screen.dart';
import 'package:quizme/auth.dart';
import 'package:quizme/firebase_options.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:quizme/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'apis/firestore_db.dart';
import 'themes/app_theme.dart';

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

  var fetchedQuizzes = await FirestoreDB.getQuizzesFromFirestore();

  runApp(
    Quiz(
      quizzes: fetchedQuizzes,
    ),
  );
}

class Quiz extends StatelessWidget {
  final quizzes;
  const Quiz({super.key, required this.quizzes});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizHandler>(
          create: (context) => QuizHandler(quizzes),
        ),
        ChangeNotifierProvider<PlayQuizProvider>(
          create: (context) => PlayQuizProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appStyling(),
        routes: {
          '/': (context) => const Auth(),
          'homeScreen': (context) => const HomeScreen(),
          'loginScreen': (context) => const LoginScreen(),
          'signupScreen': (context) => const SignupScreen(),
          'forgotPasswordScreen': (context) => const ForgotPasswordPage(),
        },
      ),
    );
  }
}
