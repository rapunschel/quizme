import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_model.dart';

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

            // If index is 0, add Score title.
            if (index == 0) {
              buildList.add(const Text("Score"));
              buildList.add(Text(
                  "You answered ${quiz.noCorrect} out of $numberOfQuestions questions correctly!"));
              // Append first question tile if not empty.
              if (correctQuestions.isNotEmpty) {
                buildList.addAll([
                  const Text("Questions you got right"),
                  QuestionTileWidget(question: correctQuestions[index].$1),
                ]);
                return Column(children: buildList);
              }
            }

            // Keep adding questions
            if (index < numberOfQuestions) {
              // Keep returning correct questions

              if (index < correctQuestions.length) {
                return QuestionTileWidget(question: correctQuestions[index].$1);
              }

              if (index == numberOfQuestions - incorrectQuestions.length) {
                buildList.addAll([
                  const Text("Questions you got wrong"),
                  QuestionTileWidget(
                    question:
                        incorrectQuestions[index % incorrectQuestions.length]
                            .$1,
                  )
                ]);
                return Column(
                  children: buildList,
                );
              }

              return QuestionTileWidget(
                question:
                    incorrectQuestions[index % incorrectQuestions.length].$1,
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
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 25, right: 25),
      child: ListTile(
        onTap: () {
          //TODO Go to question page
        },
        title: Text(
          question.title,
          textAlign: TextAlign.center,
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
