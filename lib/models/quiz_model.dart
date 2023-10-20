// Classes to model a quiz
class Quiz {
  String title;
  List<Question> questions = [];
  String? quizDescription;

  Quiz(this.title);

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
