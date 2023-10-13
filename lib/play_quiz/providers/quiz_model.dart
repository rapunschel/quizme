import 'package:flutter/material.dart';

class QuizModel extends ChangeNotifier {
  Quiz? quiz = initiateQuiz();

  // Index for current question
  int currentQuestionIndex = 0;

  // Counters for answered questions
  int noCorrect = 0;
  int noIncorrect = 0;

  // Flag to check if current question has been answered
  bool isCurrQuestionAnswered = false;

  QuizModel();

  // Update counters
  void incrementNoCorrect() {
    if (noCorrect + noIncorrect <= currentQuestionIndex) {
      noCorrect++;
      notifyListeners();
    }
  }

  void incrementNoIncorrect() {
    if (noCorrect + noIncorrect <= currentQuestionIndex) {
      noIncorrect++;
      notifyListeners();
    }
  }

  // Getters
  int getNumberOfQuestions() {
    return quiz!.questions.length;
  }

  List getCurrentAnswers() {
    return quiz!.questions[currentQuestionIndex].answers;
  }

  Question getCurrentQuestion() {
    return quiz!.questions[currentQuestionIndex];
  }

  get title => quiz!.title;

  void getNextQuestion() {
    // Only increment if we are in range.
    if (currentQuestionIndex < quiz!.questions.length - 1) {
      currentQuestionIndex++;
      notifyListeners();
    }
  }
}

// All below for test run only, delete later
Quiz initiateQuiz() {
  Quiz quiz = Quiz("Capital of countries");

  Question question1 = Question("Capital of Sweden?");
  question1.addAnswer("Malmö", false);
  question1.addAnswer("Gothenburg", false);
  question1.addAnswer("Stockholm", true);

  Question question2 = Question("Capital of England?");
  question2.addAnswer("London", true);
  question2.addAnswer("Berlin", false);
  question2.addAnswer("Brighton", false);
  question2.addAnswer("Edinburgh", false);

  Question question3 = Question("Capital of Japan?");
  question3.addAnswer("Tokyo", true);
  question3.addAnswer("Kyoto", false);
  question3.addAnswer("Osaka", false);
  question3.addAnswer("Fukouka", false);

  quiz.addQuestion(question1);
  quiz.addQuestion(question2);
  quiz.addQuestion(question3);

  return quiz;
}

// Classes to model a quiz
class Quiz {
  String title;
  List questions = [];

  Quiz(this.title);

  void addQuestion(Question question) {
    questions.add(question);
  }
}

class Question {
  String title;
  List answers = [];

  Question(this.title);

  void addAnswer(String text, bool isCorrect) {
    answers.add(Answer(text, isCorrect));
  }
}

class Answer {
  String text;
  bool isCorrect;

  Answer(this.text, this.isCorrect);
}
