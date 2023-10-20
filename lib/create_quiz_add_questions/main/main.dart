import 'package:flutter/material.dart';
// import '../../screens/make_quiz_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_creation_provider.dart';
import '../screens/create_quiz_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 92, 199, 149)),
        useMaterial3: true,
      ),
      home: const CreateQuizScreen(title: 'Create Quiz'),
    );
  }
}
