import 'package:flutter/material.dart';
import '../make_quiz.dart';
import 'package:provider/provider.dart';
import '../provider_class.dart';

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

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key, required this.title});

  final String title;

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewQuiz(
                            title: 'Make the Quiz',
                          )),
                );
              },
              tooltip: 'Start new Quiz',
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 30),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NewQuiz(
                            title: 'Make the Quiz',
                          )),
                );
              },
              tooltip: 'Create folder',
              child: const Icon(Icons.folder_copy_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
