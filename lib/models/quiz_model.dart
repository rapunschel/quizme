// Classes to model a quiz
import 'package:flutter/material.dart';

class Quiz {
  String title;
  List<Question> questions = [];
  String? quizDescription;
  String? id = UniqueKey().toString();
  Quiz(this.title, [this.id]);
  // Alternative constructor
  Quiz.description(this.title, this.quizDescription);
  void addQuestion(Question question) {
    questions.add(question);
  }
}

class Question {
  String title;
  List<Answer> answers = [];

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
