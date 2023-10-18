import 'package:flutter/material.dart';
import 'make_quiz_screen.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_model.dart';
import '../providers/quiz_creation_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> previousQuizzes = [
      'Quiz 1',
      'Quiz 2',
      'Quiz 3',
    ];

    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text('My Sessions', style: TextStyle(fontSize: 20)),
        backgroundColor: const Color.fromARGB(143, 120, 182, 123),
      ),
      floatingActionButton: Tooltip(
        message: 'Create new',
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MakeQuizScreen(),
              ),
            );
          },
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          label: const Row(
            children: [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'Create new',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
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
                return GestureDetector(
                  onTap: () {
                    // hej PÅ DIG
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10.0),
                    color: const Color.fromARGB(255, 210, 231, 211),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // omslag
                        Text(
                          previousQuizzes[index],
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
