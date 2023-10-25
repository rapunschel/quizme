import 'package:flutter/material.dart';
import 'add_questions_screen.dart';
import '../providers/quiz_creation_provider.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../widgets/reuseable_widgets.dart';

class MakeQuizScreen extends StatefulWidget {
  final Function? callback;
  const MakeQuizScreen({super.key, this.callback});

  @override
  State<MakeQuizScreen> createState() => _MakeQuizScreenState();
}

class _MakeQuizScreenState extends State<MakeQuizScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isTitleFieldEmpty = false;

  // have to manually dispose of the controller when widget is disposed.
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to changes made to the quiz
    context.watch<QuizCreationProvider>();

    // Get reference to the provider
    QuizCreationProvider editQuizProvider =
        context.read<QuizCreationProvider>();

    // Dynamic because dart complains about the type
    // Null if there is no set quiz
    dynamic quiz = editQuizProvider.currentQuiz;
    List<Question> questions = [];

    if (quiz != null) {
      questions = quiz.questions;
      // The operator '??=' assigns a default value if the left hand side is null
      _titleController.text = quiz.title ??= "";
      _descriptionController.text = quiz.quizDescription ??= "";
    } else if (quiz == null) {
      editQuizProvider.isQuizAdded = false;
      // Clear the controller
      _titleController.clear();
      _descriptionController.clear();
    }

    return Scaffold(
      appBar: QuizmeAppBar(
          title:
              editQuizProvider.isQuizAdded ? "Editing Quiz" : "Creating Quiz"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            titleTextFormField(_isTitleFieldEmpty),
            const SizedBox(height: 20),
            descriptionTextFormField(),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              editQuizProvider.isQuizAdded
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: updateQuizInfo(quiz, editQuizProvider, context),
                    )
                  : Container(),
              addQuestionButton(quiz, editQuizProvider, context)
            ]),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  List<Widget> contents = [];
                  if (index == 0) {
                    contents.add(Text("Added Questions:",
                        style: Theme.of(context).textTheme.titleMedium));
                  }

                  contents.add(QuestionTileWidget(question: questions[index]));
                  return Column(children: contents);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton updateQuizInfo(
      quiz, QuizCreationProvider editQuizProvider, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _isTitleFieldEmpty = _titleController.text.isEmpty;
        });

        if (!_isTitleFieldEmpty) {
          // If quiz is empty,create a quiz and set the provider quiz
          if (quiz == null) {
            editQuizProvider.setCurrentQuiz(Quiz.description(
                _titleController.text, _descriptionController.text));
          } else {
            quiz.title = _titleController.text;
            quiz.quizDescription = _descriptionController.text;
          }

          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: const Text('Update Quiz Info'),
    );
  }

  ElevatedButton addQuestionButton(
      quiz, QuizCreationProvider editQuizProvider, BuildContext context) {
    return ElevatedButton(
      child: Text(editQuizProvider.isQuizAdded
          ? 'Add question'
          : 'Add Quiz (Go to add question)'),
      onPressed: () async {
        setState(() {
          _isTitleFieldEmpty = _titleController.text.isEmpty;
        });
        if (!_isTitleFieldEmpty) {
          // If quiz is null,create a quiz and set the provider quiz
          if (quiz == null) {
            Quiz quiz = Quiz.description(
              _titleController.text,
              _descriptionController.text,
            );
            editQuizProvider.setCurrentQuiz(quiz);
            editQuizProvider.isQuizAdded = true;
            widget.callback!();
          } else {
            // Update current quiz in provider.
            // Dont need to set, since we got reference
            quiz.title = _titleController.text;
            quiz.quizDescription = _descriptionController.text;
          }

          if (context.mounted) {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddQuestionScreen()));
          }
        }
      },
    );
  }

  TextFormField descriptionTextFormField() {
    return TextFormField(
        controller: _descriptionController,
        maxLines: 5,
        decoration: const InputDecoration(
          labelText: 'Description',
          hintText: 'Max 5 lines',
        ));
  }

  TextField titleTextFormField(bool validate) {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Quiz Title',
        errorText: validate ? "Must give a title" : null,
      ),
    );
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
    // Wrap with Material widget so it doesnt bleed.
    return Material(
      child: quizTilePadding(
        ListTile(
          title: Text(
            question.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          tileColor: Theme.of(context).primaryColor,
          trailing: Wrap(
            spacing: -10,
            children: <IconButton>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  //TODO implement edit question.
                },
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  //TODO implement remove question.
                  //Convert to stateful, extract List<Answer> then build updates
                },
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }
}
