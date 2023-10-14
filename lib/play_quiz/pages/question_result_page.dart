import 'package:flutter/material.dart';
import '../providers/quiz_model.dart';

class QuestionResultPage extends StatelessWidget {
  const QuestionResultPage({super.key, required this.question});

  final (Question, Answer) question;

  @override
  Widget build(BuildContext context) {
    //QuizModel quiz = context.read<QuizModel>();
    List answers = question.$1.answers;
    List correctAnswers = answers.where((answer) => answer.isCorrect).toList();
    int noCorrectAnswers = correctAnswers.length;

    // Initialize list with user's answer
    List<Widget> buildList = [];
    buildList.add(Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(question.$1.title)));
    buildList.add(const Padding(
        padding: EdgeInsets.only(top: 25), child: Text("You answered")));
    buildList.add(
      AnswerCardTile(answer: question.$2),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(question.$1.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: noCorrectAnswers + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            buildList.addAll(
              [
                const Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Text("Correct answer(s)")),
                AnswerCardTile(answer: correctAnswers[index])
              ],
            );
            return Column(
              children: buildList,
            );
          }
          // else return the rest of correct answers
          if (index < noCorrectAnswers) {
            return AnswerCardTile(answer: correctAnswers[index]);
          }

          return Padding(
            padding: const EdgeInsets.only(top: 25, left: 130, right: 130),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              child: const Text("Back"),
            ),
          );
        },
      ),
    );
  }
}

class AnswerCardTile extends StatelessWidget {
  const AnswerCardTile({
    super.key,
    required this.answer,
  });

  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 12.5, bottom: 12.5, left: 25, right: 25),
      child: ListTile(
        title: Text(
          answer.text,
          textAlign: TextAlign.center,
        ),
        tileColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
