import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_model.dart';
import 'question_result_page.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuizModel quiz = context.read<QuizModel>();
    List<(Question, Answer)> correctQuestions = quiz.getCorrectQuestions();
    List<(Question, Answer)> incorrectQuestions = quiz.getIncorrectQuestions();
    int numberOfQuestions = quiz.getNumberOfQuestions();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(quiz.title),
          centerTitle: true,
        ),
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
                    "You answered ${quiz.noCorrect} out of $numberOfQuestions questions correctly!",
                    style: Theme.of(context).textTheme.bodyLarge),
              );
              // Append first question tile if not empty.
              if (correctQuestions.isNotEmpty) {
                buildList.addAll([
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text("Questions you got right",
                          style: Theme.of(context).textTheme.titleMedium)),
                  QuestionTileWidget(questionRecord: correctQuestions[index]),
                ]);
                return Column(children: buildList);
              }
            }

            // Keep adding questions
            if (index < numberOfQuestions) {
              // Keep returning correct questions
              if (index < correctQuestions.length) {
                return QuestionTileWidget(
                    questionRecord: correctQuestions[index]);
              }

              if (index == numberOfQuestions - incorrectQuestions.length) {
                buildList.addAll([
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text("Questions you got wrong",
                        style: Theme.of(context).textTheme.titleMedium),
                  ),
                  QuestionTileWidget(
                    questionRecord:
                        incorrectQuestions[index % incorrectQuestions.length],
                  )
                ]);
                return Column(
                  children: buildList,
                );
              }

              return QuestionTileWidget(
                questionRecord:
                    incorrectQuestions[index % incorrectQuestions.length],
              );
            }

            // No more question to add, add button.
            return Padding(
              padding: const EdgeInsets.only(top: 25, left: 130, right: 130),
              child: TextButton(
                onPressed: () {
                  quiz.resetQuiz();
                  //TODO Change to go to homepage.

                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                child: const Text("Complete Quiz"),
              ),
            );
          },
        ));
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
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 25, right: 25),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionResultPage(question: questionRecord),
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
