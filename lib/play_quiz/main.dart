import 'package:flutter/material.dart';

void main() {
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quiz run test',
      theme: ThemeData(
        primaryColor: Colors.green,
        primaryColorLight: Colors.green,
        useMaterial3: true,
      ),
      home: PlayQuizPage(quiz: initiateQuiz()),
    );
  }
}

class PlayQuizPage extends StatefulWidget {
  const PlayQuizPage({super.key, required this.quiz});
  final Quiz quiz;
  @override
  State<PlayQuizPage> createState() => _PlayQuizPageState();
}

class _PlayQuizPageState extends State<PlayQuizPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Get current question & the answers
    Question question = widget.quiz.questions[_currentIndex];
    List answers = question.answers;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(child: Text(widget.quiz.title)),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: answers.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                // If index 0, put the question
                children: index == 0
                    ? <Widget>[
                        // Question title
                        Text(question.title),
                        // Put space between
                        const Padding(
                          padding: EdgeInsets.only(bottom: 150),
                        ),
                        AnswerTileWidget(answer: answers[index]),
                      ]
                    : <Widget>[
                        const Padding(padding: EdgeInsets.only(top: 25)),
                        AnswerTileWidget(
                          answer: answers[index],
                        ),
                      ],
              );
            }),
      ),
    );
  }
}

class AnswerTileWidget extends StatelessWidget {
  const AnswerTileWidget({
    super.key,
    required this.answer,
  });
  final Answer answer;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Center(child: Text(answer.text)),

      onTap: () {
        print(answer.isCorrect);
        // TODO Rebuild listview and set correct answers
      },

      // Styling
      tileColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}

// Below for test run only, delete later
Quiz initiateQuiz() {
  Quiz quiz = Quiz("Capital of countries");

  Question question1 = Question("Capital of Sweden?");
  question1.addAnswer("Malmö", false);
  question1.addAnswer("Gothenburg", false);
  question1.addAnswer("Stockholm", true);

  Question question2 = Question("Capital of London?");
  question2.addAnswer("London", true);
  question2.addAnswer("Berlin", false);
  question2.addAnswer("Brighton", false);
  question2.addAnswer("Edinburgh", false);

  Question question3 = Question("Capital of Japan?");
  question2.addAnswer("Tokyo", true);
  question2.addAnswer("Kyoto", false);
  question2.addAnswer("Osaka", false);
  question2.addAnswer("Fukouka", false);

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
