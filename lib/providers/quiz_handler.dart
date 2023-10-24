import 'package:flutter/material.dart';
import 'play_quiz_provider.dart';
import '../models/quiz_model.dart';
import 'load_data.dart';

// Contain a list of all quizzes made.
class QuizHandler extends ChangeNotifier {
  List<Quiz> quizzes = [];
  bool _updateFlag = false;

  QuizHandler(this.quizzes);

  // Only used for undoing deletion
  Quiz? lastRemovedQuiz;
  Future<void> addQuiz(Quiz quiz) async {
    // If quiz already exists, update it
    if (!quizzes.contains(quiz)) {
      quizzes.add(quiz);
      await FirebaseProvider.saveQuizToFirestore(quiz);
    } else {
      await FirebaseProvider.editQuizInFireSTore(quiz);
    }
    notifyListeners();
  }

  Future<void> editQuiz(Quiz quiz) async {
    await FirebaseProvider.editQuizInFireSTore(quiz);
  }

  void removeQuiz(Quiz quiz) {
    if (quizzes.remove(quiz)) {
      lastRemovedQuiz = quiz;
    }

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
