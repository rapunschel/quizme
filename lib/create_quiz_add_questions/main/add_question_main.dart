import 'package:flutter/material.dart';
import '../screens/add_questions_screen.dart'; // Make sure to import the AddQuestionScreen file

void main() => runApp(QuestionApp());

class QuestionApp extends StatelessWidget {
  const QuestionApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Question App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AddQuestionScreen(), // Updated this line
    );
  }
}
