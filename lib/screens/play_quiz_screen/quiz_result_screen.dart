import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/play_quiz_provider.dart';
import 'question_result_screen.dart';
import '../../widgets/reuseable_widgets.dart';
import '../../models/quiz_model.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PlayQuizProvider quiz = context.read<PlayQuizProvider>();
    List<(Question, Answer)> correctQuestions = quiz.getCorrectQuestions();
    List<(Question, Answer)> incorrectQuestions = quiz.getIncorrectQuestions();
    int numberOfQuestions = quiz.getNumberOfQuestions();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(quiz.title),
          centerTitle: true,
        ),
        floatingActionButton: CompleteQuizButton(quiz: quiz),
        body: ListView.builder(
          itemCount: numberOfQuestions + 1,
          itemBuilder: (context, index) {
            List<Widget> buildList = [];

            // If index is 0, add Score title & counter for correct questions.
            if (index == 0) {
              buildList.add(Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Text("Score",
                    style: Theme.of(context).textTheme.titleLarge),
              ));
              buildList.add(
                Text(
                    "You scored ${quiz.noCorrect} out of $numberOfQuestions questions!",
                    style: Theme.of(context).textTheme.bodyLarge),
              );
              // Append first question tile if not empty.
              if (incorrectQuestions.isNotEmpty) {
                buildList.addAll([
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text("Questions you got wrong",
                          style: Theme.of(context).textTheme.titleMedium)),
                  QuestionTileWidget(questionRecord: incorrectQuestions[index]),
                ]);
                return Column(children: buildList);
              }
            }

            // Keep adding questions
            if (index < numberOfQuestions) {
              // Keep returning incorrect questions
              if (index < incorrectQuestions.length) {
                return QuestionTileWidget(
                    questionRecord: incorrectQuestions[index]);
              }

              if (index == numberOfQuestions - correctQuestions.length) {
                buildList.addAll([
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Questions you got right",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  QuestionTileWidget(
                    questionRecord:
                        correctQuestions[index % correctQuestions.length],
                  )
                ]);
                return Column(
                  children: buildList,
                );
              }

              return QuestionTileWidget(
                questionRecord:
                    correctQuestions[index % correctQuestions.length],
              );
            }

            // Padding between floatingActionButton and last element of listview
            return const Padding(
              padding:
                  EdgeInsets.only(top: 57.5, left: 115, right: 115, bottom: 50),
            );
          },
        ));
  }
}

class CompleteQuizButton extends StatelessWidget {
  const CompleteQuizButton({
    super.key,
    required this.quiz,
  });

  final PlayQuizProvider quiz;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 115, right: 115, bottom: 25),
      child: TextButton(
        onPressed: () {
          quiz.resetQuiz();
          Navigator.of(context)
            ..pop()
            ..pop();
        },
        child: const Text("Complete Quiz"),
      ),
    );
  }
}

class QuestionTileWidget extends StatelessWidget {
  const QuestionTileWidget({
    super.key,
    required this.questionRecord,
  });

  final (Question, Answer) questionRecord;

  @override
  Widget build(BuildContext context) {
    return playQuizTilePadding(
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionResultScreen(question: questionRecord),
              ));
        },
        title: Text(
          questionRecord.$1.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        tileColor: Theme.of(context).primaryColor,
        trailing: const Icon(Icons.chevron_right),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
