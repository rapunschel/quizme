import 'package:flutter/material.dart';
import 'package:quizme/screens/play_quiz_screen/play_quiz_screen.dart';
import 'package:quizme/widgets/reuseable_widgets.dart';
import 'make_quiz_screen.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_handler.dart';
import '../providers/play_quiz_provider.dart';
import '../models/quiz_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Quiz> quizzes;

  @override
  Widget build(BuildContext context) {
    context.watch<QuizHandler>().quizzes;
    final QuizHandler quizHandler = context.read<QuizHandler>();
    quizzes = quizHandler.quizzes;
    return Scaffold(
      appBar: const QuizmeAppBar(
        title: "My quizzes",
      ),
      floatingActionButton: createQuizFloatingButton(context, quizHandler),
      body: loadScreenContents(),
    );
  }

  Tooltip createQuizFloatingButton(
      BuildContext context, QuizHandler quizHandler) {
    return Tooltip(
      message: 'Create new',
      child: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeQuizScreen(
                  quiz: null,
                  callback: (Quiz quiz) {
                    context.read<QuizHandler>().addQuiz(
                          quiz,
                        );
                  }),
            ),
          );
        },
        label: const Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 8.0),
            Text('Create Quiz'),
          ],
        ),
      ),
    );
  }

  Column loadScreenContents() {
    double roundedBorder = 16.0;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(roundedBorder),
          child: Material(
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(roundedBorder),
            ),
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
                    //filled: true,
                    //fillColor: const Color.fromARGB(255, 224, 219, 219),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(roundedBorder),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        loadQuizTiles(),
        loadQuizCards(),
      ],
    );
  }

  Expanded loadQuizTiles() {
    return Expanded(
      child: ListView.builder(
          itemCount: quizzes.length + 1,
          itemBuilder: (context, index) {
            if (index < quizzes.length) {
              return QuizTile(quiz: quizzes[index % quizzes.length]);
            }

            return const SizedBox(height: 100);

            //  return Container();
          }),
    );
  }

  Expanded loadQuizCards() {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            if (index < quizzes.length) {
              return QuizCard(quiz: quizzes[index]);
            }
            return Container();
          }),
    );
  }
}

class QuizTile extends StatelessWidget {
  const QuizTile({
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
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            tileColor: Theme.of(context).primaryColor,
            title: Text(
              quiz.title,
              style: Theme.of(context).textTheme.titleLarge!,
            ),
            subtitle: Text(
              quiz.quizDescription == null ? "" : quiz.quizDescription!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.normal),
            ),
            trailing: Column(children: [
              Wrap(
                spacing: 5,
                children: [
                  editQuizButton(context, quizHandler),
                  const SizedBox(height: 5),
                  deleteQuizButton(quizHandler)
                ],
              ),
              Text('Questions: ${quiz.questions.length}',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.normal)),
            ]),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ),
    );
  }

  InkWell deleteQuizButton(QuizHandler quizHandler) {
    return InkWell(
        onTap: () {
          quizHandler.removeQuiz(quiz);
        },
        child: const Icon(Icons.delete));
  }

  InkWell editQuizButton(BuildContext context, QuizHandler quizHandler) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MakeQuizScreen(
                  quiz: quiz,
                  callback: (Quiz quiz) {
                    quizHandler.editQuiz(quiz);
                  }),
            ),
          );
        },
        child: const Icon(Icons.edit));
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
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                ),
              ],
            ),
            Positioned(
              bottom: 25.0,
              right: 10.0,
              child: Wrap(spacing: -5, children: [
                // Edit Quiz button
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MakeQuizScreen(
                              quiz: quiz,
                              callback: (Quiz quiz) {
                                quizHandler.editQuiz(quiz);
                              }),
                        ),
                      );
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
              child: Text('${quiz.questions.length} Questions',
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          ],
        ),
      ),
    );
  }
}
