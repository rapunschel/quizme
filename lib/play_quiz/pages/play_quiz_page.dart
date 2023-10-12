import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_model.dart';

class PlayQuizPage extends StatelessWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the currentIndex.
    context.watch<QuizModel>().currentQuestionIndex;

    // Retrieve the QuizModel
    QuizModel quiz = context.read<QuizModel>();

    // Get current question & the answers
    Question question = quiz.getCurrentQuestion();
    List answers = quiz.getCurrentAnswers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        //  title: Center(child: Text(quiz.title)),
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
        // TODO Listen if an answer been pressed,
        // update listTile color based on correct / wrong
        if (answer.isCorrect) {
          context.read<QuizModel>().getNextQuestion();
        }
      },

      // Styling
      tileColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
