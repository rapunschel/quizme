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

    // Build contents
    List<Widget> quizContents = [
          Center(child: questionCounter(quiz, 30)),
          resultCounter(context, 10),
          // Question title
          Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 75),
                  child: Text(question.title))),
        ] +
        answers
            .map((answer) => Padding(
                padding: const EdgeInsets.only(
                    top: 12.5, bottom: 12.5, left: 25, right: 25),
                child: AnswerTileWidget(answer: answer)))
            .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Center(child: Text(quiz.title)),
      ),
      body: ListView(children: quizContents),
    );
  }

  Padding resultCounter(BuildContext context, double topPadding) {
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

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconText(10, "${context.watch<QuizModel>().noCorrect}",
              Icons.check_circle_rounded, Colors.green),
          iconText(10, "${context.watch<QuizModel>().noIncorrect}",
              Icons.cancel, Colors.red),
        ],
      ),
    );
  }

  Padding questionCounter(QuizModel quiz, double topPadding) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
          "Question : ${quiz.currentQuestionIndex + 1} / ${quiz.getNumberOfQuestions()}"),
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
