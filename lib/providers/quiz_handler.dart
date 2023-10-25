import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../apis/firestore_db.dart';

// Contain a list of all quizzes made.
class QuizHandler extends ChangeNotifier {
  List<Quiz> quizzes = [];

  QuizHandler(this.quizzes);

  Future<void> addQuiz(Quiz quiz) async {
    // If quiz already exists, update it
    if (!quizzes.contains(quiz)) {
      await FirestoreDB.saveQuizToFirestore(quiz);
      await fetchQuizzes();
    }
  }

  Future<void> editQuiz(Quiz quiz) async {
    await FirestoreDB.editQuizInFireSTore(quiz);
    // await for fetchQuizzes to finish, to give homepage time to get changes
    await fetchQuizzes();
  }

  void removeQuiz(Quiz quiz) async {
    if (await FirestoreDB.deleteQuizFromFirestore(quiz)) {
      // lastRemovedQuiz = quiz;
      await fetchQuizzes();
    }
    notifyListeners();
  }

  // Need to await when calling this function,
  //to give time for homepage to update (else you see the change happening)
  Future<void> fetchQuizzes() async {
    await FirestoreDB.getQuizzesFromFirestore().then((fetchedQuizzes) {
      quizzes = fetchedQuizzes;
    });
    notifyListeners();
  }

  List<Quiz> getQuizzes() {
    return quizzes;
  }
}
