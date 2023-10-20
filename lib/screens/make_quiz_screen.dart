import 'package:flutter/material.dart';
import 'add_questions_screen.dart';
import '../create_quiz_add_questions/model/question_model.dart';
import '../create_quiz_add_questions/model/quiz_class.dart';
import '../providers/quiz_creation_provider.dart';
import 'package:provider/provider.dart';

class MakeQuizScreen extends StatefulWidget {
  const MakeQuizScreen({super.key});

  @override
  State<MakeQuizScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MakeQuizScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Quiz> quizzes = [];

  void addQuiz(BuildContext context) {
    String quizTitle = _titleController.text;
    String descriptionTitle = _descriptionController.text;

    // Create a new question with the quiz title and description
    Question question = Question(
      question: quizTitle,
      answers: [
        descriptionTitle
      ], // Using description as the answer for simplicity
      correctAnswerIndex: 0, // Assuming the only answer is correct
      quizTitle: quizTitle,
      quizDescription: descriptionTitle,
    );

    // Add the question to the current quiz
    Provider.of<QuizProvider>(context, listen: false)
        .addQuestionToCurrentQuiz(question);

    _titleController.clear();
    _descriptionController.clear();

    setState(() {
/*       quizzes = Provider.of<QuizProvider>(context, listen: false)
          .setCurrentQuiz(newQuiz); */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Make the Quiz'),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Quiz Title',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Max 5 lines',
                  )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  addQuiz(context);
                  // Set the current quiz
                  Provider.of<QuizProvider>(context, listen: false)
                      .setCurrentQuiz(
                    Quiz(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      questions: [],
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddQuestionScreen()));
                },
                child: const Text('Next Step (add questions)'),
              ),
              /*  const SizedBox(height: 20),
              Expanded(
                child: QuestionList(),
                //ListView.builder(
                //  itemCount: quizzes.length,
                //  itemBuilder: (context, index) {
                //   return Card(
                //    child: ListTile(
                //      title: Text('Title: ${quizzes[index].title}'),
                //     subtitle: Text('Description: ${quizzes[index].description}'),
              ), */
            ])));
  }
  // ),
  // ),
  //   ]
  //  ),
  // )
  // );
}
//}
