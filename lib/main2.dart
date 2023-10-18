import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_model.dart';
import 'providers/quiz_creation_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/homepage.dart';
import 'screens/play_quiz_screen/play_quiz.dart';
import 'package:quizme/auth.dart';
import 'package:quizme/firebase_options.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:quizme/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const Quiz());
}

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizProvider>(
            create: (context) => QuizProvider()),
      ],
      child: MaterialApp(
        home: const HomePage(),
        theme: appStyling(context),
      ),
    );
  }

  ThemeData appStyling(BuildContext context) {
    Color primaryColor = const Color.fromARGB(255, 201, 237, 244);
    Color buttonColor = const Color.fromARGB(255, 153, 225, 239);
    return ThemeData(
        primaryColor: primaryColor,
        fontFamily: GoogleFonts.openSans().fontFamily,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.normal),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(3),
            backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          ),
        ),
        textTheme: const TextTheme(
            // Global styling, use Theme... to use a specific style
            //and copyWith to overwrite specific values
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
            // Edit
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(),
            bodyLarge: TextStyle(),
            bodyMedium: TextStyle(),
            // Buttons uses labelLarge
            labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)));
  }
}
