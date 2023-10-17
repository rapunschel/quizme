import 'package:flutter/material.dart';
import 'question_model.dart';

class QuestionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questions = QuestionStorage.getQuizQuestions();

    return Scaffold(
      appBar: AppBar(
        title: Text('Questions List'),
      ),
      body: ListView.builder(
  itemCount: questions.length, // Assuming quizQuestions is a list of QuizQuestion objects
  itemBuilder: (context, index) {
    final quizQuestion = questions[index]; // Access each QuizQuestion

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Display the quiz title and description
        ListTile(
          title: Text('Quiz Title: ${quizQuestion.quizTitle}'),
          subtitle: Text('Description: ${quizQuestion.quizDescription}'),
        ),
        // Display the questions for the current quiz
        ListTile(
          title: Text('Questions:'),
        ),
        ...quizQuestion.question.answers.asMap().entries.map((entry) {
          int idx = entry.key;
          String answer = entry.value;
          return ListTile(
            title: Text('${quizQuestion.question.question}'),
            subtitle: Row(
              children: [
                Expanded(child: Text(answer)),
                if (quizQuestion.question.correctAnswerIndex == idx)
                  Icon(Icons.check, color: Colors.green),
              ],
            ),
          );
        }).toList(),
      ],
    );
  },
),

    );
  }
}