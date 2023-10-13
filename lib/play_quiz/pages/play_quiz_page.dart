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
        title: Center(child: Text(quiz.title)),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: answers.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                // If index 0, put the question
                children: index == 0
                    ? <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                              "Question : ${quiz.currentQuestionIndex + 1} / ${quiz.getNumberOfQuestions()}"),
                        ),
                        // Counter for correct / incorrent answers
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconText(
                                10,
                                "${context.watch<QuizModel>().noCorrect}",
                                Icons.check_circle_rounded,
                                Colors.green),
                            iconText(
                                10,
                                "${context.watch<QuizModel>().noIncorrect}",
                                Icons.cancel,
                                Colors.red),
                          ],
                        ),

                        // Question title
                        Text(question.title),
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: AnswerTileWidget(answer: answers[index]),
                        ),
                      ]
                    : <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: AnswerTileWidget(answer: answers[index]),
                        ),
                      ],
              );
            }),
      ),
    );
  }

  Padding iconText(double rightPadding, String text, var icon, var color) {
    return Padding(
      padding: EdgeInsets.only(right: rightPadding),
      child: Wrap(
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(text),
        ],
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
        // Get reference but don't listen to changes
        QuizModel quiz = context.read<QuizModel>();

        if (answer.isCorrect) {
          quiz.incrementNoCorrect();
        } else {
          quiz.incrementNoIncorrect();
        }
        quiz.getNextQuestion();
      },

      // Styling
      tileColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    );
  }
}
