import 'package:flutter/material.dart';
import 'add_questions_screen.dart';
import '../models/quiz_model.dart';
import '../widgets/reuseable_widgets.dart';

class MakeQuizScreen extends StatefulWidget {
  final Function callback;
  final Quiz? quiz;
  const MakeQuizScreen({super.key, this.quiz, required this.callback});

  @override
  State<MakeQuizScreen> createState() => _MakeQuizScreenState();
}

class _MakeQuizScreenState extends State<MakeQuizScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isTitleFieldEmpty = false;
  bool? isQuizAdded;
  Quiz? resultQuiz;

  @override
  void initState() {
    resultQuiz = widget.quiz;
    super.initState();
  }

  // have to manually dispose of the controller when widget is disposed.
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Question> questions = [];

    // If quiz is not null, initialize variables.
    if (resultQuiz != null) {
      isQuizAdded = true;
      questions = resultQuiz!.questions;
      _titleController.text = resultQuiz!.title;
      _descriptionController.text = resultQuiz!.quizDescription ??= "";
    } // if quiz is null, clear textfields
    else if (resultQuiz == null) {
      isQuizAdded = false;
      _titleController.clear();
      _descriptionController.clear();
    }

    return Scaffold(
      appBar:
          QuizmeAppBar(title: isQuizAdded! ? "Editing Quiz" : "Creating Quiz"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            titleTextFormField(_isTitleFieldEmpty),
            const SizedBox(height: 20),
            descriptionTextFormField(),
            const SizedBox(height: 20),
            loadButtons(context),
            loadQuestions(questions)
          ],
        ),
      ),
    );
  }

  Expanded loadQuestions(List<Question> questions) {
    return Expanded(
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          List<Widget> contents = [];
          if (index == 0) {
            contents.add(Text("Added Questions:",
                style: Theme.of(context).textTheme.titleMedium));
          }

          contents.add(
            QuestionTileWidget(
              question: questions[index],
              editQuestionCallback: () async {
                /*           await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddQuestionScreen(quiz: resultQuiz!)));
                await widget.callback(resultQuiz); */
              },
              removeQuestionCallback: (Question question) async {
                // removed question
                resultQuiz!.questions.remove(question);
                // Update firestore with callback
                await widget.callback(resultQuiz!);
                setState(() {/* rebuild */});
              },
            ),
          );
          return Column(children: contents);
        },
      ),
    );
  }

  Row loadButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      isQuizAdded!
          ? Padding(
              padding: const EdgeInsets.only(right: 15),
              child: updateQuizButton(resultQuiz!, context),
            )
          : Container(),
      addQuestionButton(resultQuiz, context)
    ]);
  }

  ElevatedButton updateQuizButton(Quiz quiz, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          _isTitleFieldEmpty = _titleController.text.isEmpty;
        });
        if (!_isTitleFieldEmpty) {
          quiz.title = _titleController.text;
          quiz.quizDescription = _descriptionController.text;
          await widget.callback(quiz);
          if (context.mounted) Navigator.of(context).pop();
        }
      },
      child: const Text('Update Quiz Info'),
    );
  }

  ElevatedButton addQuestionButton(Quiz? quiz, BuildContext context) {
    return ElevatedButton(
      child:
          Text(isQuizAdded! ? 'Add question' : 'Add Quiz (Go to add question)'),
      onPressed: () async {
        setState(() {
          _isTitleFieldEmpty = _titleController.text.isEmpty;
        });

        if (!_isTitleFieldEmpty) {
          // If quiz is null,create a quiz
          if (resultQuiz == null) {
            quiz = Quiz.description(
              _titleController.text,
              _descriptionController.text,
            );

            resultQuiz = Quiz.description(
                _titleController.text, _descriptionController.text);
            isQuizAdded = true;

            widget.callback(resultQuiz);
          } else {
            resultQuiz!.title = _titleController.text;
            resultQuiz!.quizDescription = _descriptionController.text;
          }

          if (!context.mounted) return;

          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddQuestionScreen(quiz: resultQuiz!)));

          setState(() {/* Rebuild */});
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

class QuestionTileWidget extends StatefulWidget {
  const QuestionTileWidget({
    super.key,
    required this.question,
    required this.editQuestionCallback,
    required this.removeQuestionCallback,
  });

  final Function editQuestionCallback;
  final Function removeQuestionCallback;
  final Question question;

  @override
  State<QuestionTileWidget> createState() => _QuestionTileWidgetState();
}

class _QuestionTileWidgetState extends State<QuestionTileWidget> {
  @override
  Widget build(BuildContext context) {
    // Wrap with Material widget so it doesnt bleed.
    return Material(
      child: quizTilePadding(
        ListTile(
          title: Text(
            widget.question.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          tileColor: Theme.of(context).primaryColor,
          trailing: Wrap(
            spacing: -10,
            children: <IconButton>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  //TODO fix
                  // await widget.editQuestionCallback();
                  setState(() {
                    // Rebuild
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  await widget.removeQuestionCallback(widget.question);
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
