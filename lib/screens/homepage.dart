import 'package:flutter/material.dart';
import 'package:quizme/providers/quiz_creation_provider.dart';
import 'package:quizme/screens/play_quiz_screen/play_quiz_screen.dart';
import 'package:quizme/widgets/reuseable_widgets.dart';
import 'make_quiz_screen.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_handler.dart';
import '../providers/play_quiz_provider.dart';
import '../models/quiz_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Quiz> quizzes;

  @override
  Widget build(BuildContext context) {
    QuizCreationProvider quizCreationProvider =
        context.read<QuizCreationProvider>();

    context.watch<QuizHandler>();
    final QuizHandler quizHandler = context.read<QuizHandler>();
    quizzes = quizHandler.quizzes;
    return Scaffold(
      appBar: const QuizmeAppBar(
        title: "My quizzes",
      ),
      // Floating Button
      floatingActionButton: Tooltip(
        message: 'Create new',
        child: FloatingActionButton.extended(
          onPressed: () async {
            // Reset provider for making quiz
            quizCreationProvider.reset();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MakeQuizScreen(),
              ),
            );
            // Only add the quiz to firestore if the quiz is marked as added.
            if (context.mounted && quizCreationProvider.isQuizAdded) {
              // add the quiz
              await context
                  .read<QuizHandler>()
                  .addQuiz(quizCreationProvider.currentQuiz!);
            }
            setState(() {/* Rebuild */});
          },
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          label: const Row(
            children: [
              Icon(Icons.add),
              SizedBox(width: 8.0),
              Text('Create Quiz'),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
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
              itemCount: quizzes.length,
              itemBuilder: (context, index) {
                if (index < quizzes.length) {
                  return QuizCard(quiz: quizzes[index]);
                }
                return Container(); // Placeholder, you can customize this as needed
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
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final Quiz quiz;

  @override
  Widget build(BuildContext context) {
    QuizHandler quizHandler = context.read<QuizHandler>();
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
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  quiz.title,
                  style: const TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 25.0,
              right: 10.0,
              child: Wrap(spacing: -5, children: [
                // Edit Quiz button
                IconButton(
                    onPressed: () async {
                      QuizCreationProvider qcProvider =
                          context.read<QuizCreationProvider>();
                      qcProvider.reset();
                      qcProvider.setCurrentQuiz(quiz);
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MakeQuizScreen(),
                        ),
                      );

                      quizHandler.editQuiz(quiz);
                    },
                    icon: const Icon(Icons.edit)),
                // Delete Quiz button
                IconButton(
                    onPressed: () {
                      quizHandler.removeQuiz(quiz);
                    },
                    icon: const Icon(Icons.delete))
              ]),
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
