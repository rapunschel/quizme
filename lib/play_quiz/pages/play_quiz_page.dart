import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_model.dart';
import '../pages/quiz_result_page.dart';

class PlayQuizPage extends StatelessWidget {
  const PlayQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the currentIndex.
    context.watch<QuizModel>().currentQuestionIndex;
    QuizModel quiz = context.read<QuizModel>();
    Question question = quiz.getCurrentQuestion();
    List answers = quiz.getCurrentAnswers();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(quiz.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: quiz.isAnswered ? answers.length + 1 : answers.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Wrap(
              children: [
                Center(child: questionCounter(quiz, 30)),
                resultCounter(context, 10),
                Center(
                    child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 75),
                        child: Text(question.title))),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 12.5, bottom: 12.5, left: 25, right: 25),
                  child: AnswerTileWidget(answer: answers[index]),
                ),
              ],
            );
          }

          // If quiz is answered, add button
          if (quiz.isAnswered && index == answers.length) {
            // If on last question, add "Quiz Result" button
            if (quiz.currentQuestionIndex + 1 == quiz.getNumberOfQuestions()) {
              return Padding(
                padding: const EdgeInsets.only(top: 25, left: 130, right: 130),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizResultPage(),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                  ),
                  child: const Text("Quiz Result"),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(top: 25, left: 130, right: 130),
              child: TextButton(
                onPressed: () {
                  quiz.getNextQuestion();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                child: const Text("Next question"),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
                top: 12.5, bottom: 12.5, left: 25, right: 25),
            child: AnswerTileWidget(answer: answers[index]),
          );
        },
      ),
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

class AnswerTileWidget extends StatefulWidget {
  const AnswerTileWidget({
    super.key,
    required this.answer,
  });
  final Answer answer;

  @override
  State<AnswerTileWidget> createState() => _AnswerTileWidgetState();
}

class _AnswerTileWidgetState extends State<AnswerTileWidget> {
  // Keep track of which listTile was tapped.
  bool wasTapped = false;
  @override
  Widget build(BuildContext context) {
    // Be notified on changes to the variable.
    context.watch<QuizModel>().isAnswered;
    // Get reference but don't listen to changes
    QuizModel quiz = context.read<QuizModel>();
    Color color = Theme.of(context).primaryColor;

    if (quiz.isAnswered) {
      // Check if the tile wasTapped and set correct color
      if (wasTapped) {
        if (widget.answer.isCorrect) {
          color = Colors.greenAccent;
        } else {
          color = const Color.fromARGB(255, 252, 105, 105);
        }
      }
      // If it wasnt tapped but was also a correct answer, set to green.
      else if (widget.answer.isCorrect) {
        // Update color
        color = Colors.greenAccent;
      }
    }
    // IF quiz is not answered reset wasTapped to false.
    else {
      wasTapped = false;
    }
    return ListTile(
      title: Center(child: Text(widget.answer.text)),
      onTap: () {
        wasTapped = true;
        if (widget.answer.isCorrect) {
          quiz.incrementNoCorrect();
        } else {
          quiz.incrementNoIncorrect();
        }
        // addDoneQuestion() must be called before update.
        quiz.addDoneQuestion(widget.answer);
        quiz.updateIsAnswered();
      },

      // Styling
      tileColor: color,
      // Highlight tapped listTile.
      shape: wasTapped
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: const BorderSide(color: Colors.black, width: 2))
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
    );
  }
}
