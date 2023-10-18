import 'package:flutter/foundation.dart';
import 'quiz_class.dart';
import 'question_model.dart';

class QuizProvider with ChangeNotifier {
  Quiz? currentQuiz; // The current quiz being created

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
}
