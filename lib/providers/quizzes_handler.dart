import 'package:flutter/material.dart';
import 'quiz_model.dart';

// Contain a list of all quizzes made.
class QuizHandler extends ChangeNotifier {
  List<Quiz> _quizzes = [initiateQuiz(), initiateQuiz2()];

  void addQuiz(Quiz quiz) {
    _quizzes.add(quiz);
  }

  void removeQuiz(Quiz quiz) {
    throw UnimplementedError();
  }

  List<Quiz> getQuizzes() {
    return _quizzes;
  }
}
