import 'package:flutter/material.dart';
import 'package:quizme/providers/quiz_creation_provider.dart';
import 'package:quizme/screens/play_quiz_screen/play_quiz_screen.dart';
import 'make_quiz_screen.dart';
import 'package:provider/provider.dart';
import '../providers/quizzes_handler.dart';
import '../providers/play_quiz_provider.dart';
import '../models/quiz_model.dart';
import '../widgets/reuseable_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<QuizHandler>().quizzes;
    final QuizHandler quizHandler = context.read<QuizHandler>();
    final List<Quiz> previousQuizzes = quizHandler.getQuizzes();

    return Scaffold(
      //backgroundColor: Colors.white12,
      appBar: const QuizmeAppBar(
        title: "My quizzes",
      ),
      floatingActionButton: Tooltip(
        message: 'Create new',
        child: FloatingActionButton.extended(
          onPressed: () {
            // Reset provider for making quiz
            context.read<QuizCreationProvider>().reset();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MakeQuizScreen(),
              ),
            );
          },
          backgroundColor: Theme.of(context).primaryColor, //Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          label: Row(
            children: [
              const Icon(
                Icons.add, /* color: Colors.white */
              ),
              const SizedBox(width: 8.0),
              Text('Create Quiz',
                  style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 500.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 50.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search...',
                    filled: true,
                    fillColor: const Color.fromARGB(255, 224, 219, 219),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: previousQuizzes.length,
              itemBuilder: (context, index) {
                if (index < previousQuizzes.length) {
                  return QuizCard(quiz: previousQuizzes[index]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.quiz,
  });

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    final PlayQuizProvider playQuizModel = context.read<PlayQuizProvider>();
    return GestureDetector(
      onTap: () {
        // Must set quiz before pushing to the PlayQuizScreen
        playQuizModel.setQuiz(quiz);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PlayQuizScreen(),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10.0),
        color: Theme.of(context)
            .primaryColor, //const Color.fromARGB(255, 210, 231, 211),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // omslag
                Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 30.0,
                    // color: Colors.grey,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: Text(
                '${quiz.questions.length} Questions',
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
