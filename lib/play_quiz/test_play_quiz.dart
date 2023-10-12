import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_model.dart';
import 'pages/play_quiz_page.dart';

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
          primaryColor: Colors.green,
          primaryColorLight: Colors.green,
          useMaterial3: true,
        ),
        home: const PlayQuizPage(),
      ),
    );
  }
}
