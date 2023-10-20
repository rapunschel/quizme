import 'package:flutter/material.dart';
import '../../screens/make_quiz_screen.dart';
// import 'package:provider/provider.dart';
// import '../provider_class.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key, required this.title});

  final String title;

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
            ),
          ],
        ),
      ),
      floatingActionButton: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            createQuizButton(context),
            const SizedBox(height: 30),
            // folderButton(context),
          ],
        ),
      ),
    );
  }

  FloatingActionButton createQuizButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MakeQuizScreen()),
        );
      },
      tooltip: 'Start new Quiz',
      child: const Icon(Icons.add),
    );
  }

  FloatingActionButton folderButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MakeQuizScreen()),
        );
      },
      tooltip: 'Create folder',
      child: const Icon(Icons.folder_copy_outlined),
    );
  }
}
