import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_model.dart';
import 'quiz_result_screen.dart';
import '../../widgets/reuseable_widgets.dart';

class PlayQuizScreen extends StatelessWidget {
  const PlayQuizScreen({super.key});

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
        // If quiz is answered, add +1 to account for button
        itemCount: quiz.isAnswered ? answers.length + 1 : answers.length,
        itemBuilder: (context, index) {
          // Add the counters and question and first answer option.
          if (index == 0) {
            return Wrap(
              children: [
                Center(child: questionCounter(context, quiz, 20)),
                resultCounter(context, 10),
                Center(child: questionTitleWidget(context, question)),
                AnswerTileWidget(answer: answers[index]),
              ],
            );
          }

          // Finished adding all answers, add the correct button
          if (quiz.isAnswered && index == answers.length) {
            // If on last question, add "Quiz Result" button
            if (quiz.currentQuestionIndex + 1 == quiz.getNumberOfQuestions()) {
              return quizResultButton(context);
            }
            // Not on last question, put "next question "button"
            return nextQuestionButton(quiz, context);
          }

          return AnswerTileWidget(answer: answers[index]);
        },
      ),
    );
  }

  Padding nextQuestionButton(QuizModel quiz, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 115, right: 115),
      child: TextButton(
        onPressed: () {
          quiz.getNextQuestion();
        },
        child: const Text("Next question"),
      ),
    );
  }

  Padding quizResultButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 115, right: 115),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QuizResultScreen(),
            ),
          );
        },
        child: const Text("Quiz Result"),
      ),
    );
  }

  Padding questionTitleWidget(BuildContext context, Question question) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 45, bottom: 45, left: 12.5, right: 12.5),
      child:
          Text(question.title, style: Theme.of(context).textTheme.titleMedium),
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
            Text(text, style: Theme.of(context).textTheme.bodyLarge),
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

  Padding questionCounter(BuildContext context, quiz, double topPadding) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Text(
          "Question : ${quiz.currentQuestionIndex + 1} / ${quiz.getNumberOfQuestions()}",
          style: Theme.of(context).textTheme.titleLarge),
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
        color = Colors.greenAccent;
      }
    }
    // If quiz is not answered reset wasTapped to false.
    else {
      wasTapped = false;
    }
    return playQuizTilePadding(ListTile(
      title: Center(
        child: Text(widget.answer.text,
            style: Theme.of(context).textTheme.bodyLarge),
      ),
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
    ));
  }
}
