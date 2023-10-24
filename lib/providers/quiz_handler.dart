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
  //Quiz? lastRemovedQuiz;

  Future<void> addQuiz(Quiz quiz) async {
    // If quiz already exists, update it
    if (!quizzes.contains(quiz)) {
      await FirebaseProvider.saveQuizToFirestore(quiz);
      await fetchQuizzes();
    }
  }

  Future<void> editQuiz(Quiz quiz) async {
    await FirebaseProvider.editQuizInFireSTore(quiz);
    // await for fetchQuizzes to finish, to give homepage time to get changes
    await fetchQuizzes();
  }

  void removeQuiz(Quiz quiz) async {
    if (await FirebaseProvider.deleteQuizFromFirestore(quiz)) {
      // lastRemovedQuiz = quiz;
      await fetchQuizzes();
    }
    notifyListeners();
  }

  // Need to await when calling this function,
  //to give time for homepage to update (else you see the change happening)
  Future<void> fetchQuizzes() async {
    await FirebaseProvider.getQuizzesFromFirestore().then((fetchedQuizzes) {
      quizzes = fetchedQuizzes;
    });
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
