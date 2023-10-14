import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_model.dart';
import 'pages/play_quiz_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const Play());
}

class Play extends StatelessWidget {
  const Play({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizModel(),
      child: MaterialApp(
        title: 'quiz run test',
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 192, 241, 251),
            primaryColorLight: Colors.green,
            fontFamily: GoogleFonts.openSans().fontFamily,
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              titleTextStyle: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            textTheme: const TextTheme(
                // Global styling, use Theme... to use a specific style
                //and copyWith to overwrite specific values
                titleLarge: TextStyle(fontWeight: FontWeight.bold),
                // Edit
                titleMedium:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                titleSmall: TextStyle(),
                bodyLarge: TextStyle(),
                bodyMedium: TextStyle(),
                // Buttons uses labelLarge
                labelLarge:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
        home: const PlayQuizPage(),
      ),
    );
  }
}
