import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key});

  final List<String> previousQuizzes = [
    'Quiz 1',
    'Quiz 2',
    'Quiz 3',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text('My Sessions', style: TextStyle(fontSize: 20)),
        backgroundColor: Color.fromARGB(143, 120, 182, 123),
      ),
      floatingActionButton: Tooltip(
        message: 'Create new',
        child: FloatingActionButton.extended(
          onPressed: () {
            // knapp för en ny quiz
          },
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          label: Row(
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
                constraints: BoxConstraints(
                  maxWidth: 50.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Color.fromARGB(255, 224, 219, 219),
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: previousQuizzes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // hej PÅ DIG
                  },
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    color: Color.fromARGB(255, 210, 231, 211),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // omslag
                        Text(
                          previousQuizzes[index],
                          style: TextStyle(
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
