import 'package:flutter/foundation.dart';
import '../models/quiz_model.dart';

class QuizCreationProvider with ChangeNotifier {
  Quiz? currentQuiz; // The current quiz being created

  bool isQuizAdded = true;
  // Set the current quiz
  void setCurrentQuiz(Quiz quiz) {
    currentQuiz = quiz;
    notifyListeners();
  }

  // Add a question to the current quiz
  void addQuestionToCurrentQuiz(Question question) {
    if (currentQuiz != null) {
      currentQuiz!.questions.add(question);
      notifyListeners();
    }
  }

  void reset() {
    currentQuiz = null;
    isQuizAdded = true;
    notifyListeners();
  }
}
