import 'package:flutter/material.dart';
import '../model/question_model.dart';
import 'question_list_screen.dart';
import '../provider_class.dart';
import 'package:provider/provider.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _question = '';
  String _quizTitle = '';
  String _quizDescription = '';
  List<String> _answers = ['', '', '', ''];
  int? _correctAnswerIndex;
  List<bool> _isAnswerSelected = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionList(),
                ),
              );
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Enter your question and provide four possible answers. Mark the correct answer.',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              onChanged: (value) => _question = value,
              decoration: const InputDecoration(
                labelText: 'Question',
                hintText: 'Enter your question here',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
              maxLines: 3,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            ..._answers.asMap().entries.map((entry) {
              int index = entry.key;
              return ListTile(
                title: TextFormField(
                  onChanged: (value) => _answers[index] = value,
                  decoration: InputDecoration(
                    labelText: 'Answer ${index + 1}',
                  ),
                ),
                leading: Checkbox(
                  value: _isAnswerSelected[index],
                  onChanged: (value) {
                    setState(() {
                      for (int i = 0; i < _isAnswerSelected.length; i++) {
                        _isAnswerSelected[i] = false;
                      }
                      _isAnswerSelected[index] = value!;
                      _correctAnswerIndex = value ? index : null;
                    });
                  },
                ),
              );
            }).toList(),
            const SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: const Alignment(0, 0.5),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20.0),
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        _correctAnswerIndex != null) {
                      final newQuestion = Question(
                        quizTitle: _quizTitle,
                        quizDescription: _quizDescription,
                        question: _question,
                        answers: _answers,
                        correctAnswerIndex: _correctAnswerIndex!,
                      );

                      // Add the question to the current quiz
                      Provider.of<QuizProvider>(context, listen: false)
                          .addQuestionToCurrentQuiz(newQuestion);

                      // Clear the form
                      _quizTitle = '';
                      _quizDescription = '';
                      _question = '';
                      _answers = ['', '', '', ''];
                      _isAnswerSelected = [false, false, false, false];
                      _correctAnswerIndex = null;
                      setState(() {});
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
