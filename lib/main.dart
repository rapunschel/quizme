import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizme/screens/forgot_password_page.dart';
import 'providers/play_quiz_provider.dart';
import 'providers/quiz_creation_provider.dart';
import 'providers/quiz_handler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/homepage.dart';
import 'package:quizme/auth.dart';
import 'package:quizme/firebase_options.dart';
import 'package:quizme/screens/login_screen.dart';
import 'package:quizme/screens/signup_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import '../providers/load_data.dart';

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

  var fetchedQuizzes = await FirebaseProvider.getQuizzesFromFirestore();

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
        ChangeNotifierProvider<QuizCreationProvider>(
          create: (context) => QuizCreationProvider(),
        ),
        ChangeNotifierProvider<QuizHandler>(
          create: (context) => QuizHandler(quizzes),
        ),
        ChangeNotifierProvider<PlayQuizProvider>(
          create: (context) => PlayQuizProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appStyling(context),
        routes: {
          '/': (context) => const Auth(),
          'homeScreen': (context) => const HomePage(),
          'loginScreen': (context) => const LoginScreen(),
          'signupScreen': (context) => const SignupScreen(),
          'forgotPasswordScreen': (context) => const ForgotPasswordPage(),
        },
      ),
    );
  }

  ThemeData appStyling(BuildContext context) {
    Color textColor = Colors.black;
    Color primaryColor = const Color.fromARGB(
        255, 203, 213, 235); // Color.fromARGB(255, 20, 142, 54);
    Color buttonBG = const Color.fromARGB(255, 238, 240, 246);
    Color iconColor = Colors.black;
    Color buttonColor = primaryColor;
    return ThemeData(
      //  scaffoldBackgroundColor: Color.fromARGB(255, 28, 23, 32),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      fontFamily: GoogleFonts.openSans().fontFamily,
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.normal),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        extendedTextStyle: Theme.of(context).textTheme.bodyMedium,
        // Color for the icon
        foregroundColor: iconColor,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
      ),
      listTileTheme: ListTileThemeData(iconColor: iconColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(3),
        backgroundColor: MaterialStateProperty.all<Color>(buttonBG),
      )),
      snackBarTheme: SnackBarThemeData(
        //  closeIconColor: iconColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(24),
        ),
        showCloseIcon: true,
        closeIconColor: iconColor,
        actionTextColor: Colors.deepPurple,
        backgroundColor: primaryColor,
        contentTextStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      iconTheme: IconThemeData(color: iconColor),
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
              labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
          .apply(bodyColor: textColor, displayColor: textColor),
    );
  }
}
