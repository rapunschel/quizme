import 'package:flutter/material.dart';
import 'play_quiz_provider.dart';
import '../models/quiz_model.dart';

// Contain a list of all quizzes made.
class QuizHandler extends ChangeNotifier {
  List<Quiz> quizzes = [initiateQuiz(), initiateQuiz2()];
  bool _updateFlag = false;

  void addQuiz(Quiz quiz) {
    if (!quizzes.contains(quiz)) {
      quizzes.add(quiz);
    }
    notifyListeners();
  }

  void removeQuiz(Quiz quiz) {
    quizzes.remove(quiz);
    notifyListeners();
  }

  // Ugly fix: Should probably use callbacks to rebuild homepage
  // If a quiz is edited, need to tell homepage to rebuild
  void notifyQuizUpdated() {
    _updateFlag = true;
    notifyListeners();
    _updateFlag = false;
  }

  List<Quiz> getQuizzes() {
    return quizzes;
  }
}
