import 'package:flutter/material.dart';
import 'make_quiz.dart';
import 'package:provider/provider.dart';
import 'provider_class.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 92, 199, 149)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Create Quiz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), 
        centerTitle: true,
      ),
     body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                  MaterialPageRoute(builder: (context) => NewQuiz(title: 'Make the Quiz',)),
                );
              },
              child: Icon(Icons.add),
              tooltip: 'Start new Quiz',
            ),
            SizedBox(height: 30), 
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewQuiz(title: 'Make the Quiz',)),
                );
              },
              child: Icon(Icons.folder_copy_outlined),
              tooltip: 'Create folder',
            ),
          ],
        ),
      ),
    );
  }
}