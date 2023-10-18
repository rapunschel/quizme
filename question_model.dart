class Question {
  final String question;
  final List<String> answers;
  final int correctAnswerIndex;
  final String quizTitle; // Quiz title associated with this question
  final String quizDescription; // Quiz description associated with this question

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
    required this.quizTitle,
    required this.quizDescription,
  });
}

class QuizQuestion {
  final String quizTitle;
  final String quizDescription;
  final Question question;

  QuizQuestion({
    required this.quizTitle,
    required this.quizDescription,
    required this.question,
  });
}


class QuestionStorage {
  static final List<QuizQuestion> _quizQuestions = [];

  static void addQuizQuestion(QuizQuestion quizQuestion) {
    _quizQuestions.add(quizQuestion);
  }

  static List<QuizQuestion> getQuizQuestions() {
    return _quizQuestions;
  }
}

