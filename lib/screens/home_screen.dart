import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const double kDefaultPadding = 20.0;
const kGrayColor = Color(0xFFC1C1C1);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hello, you are logged in!',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          Text(
            user!.email!,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple),
          ),
          Text(user!.uid),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign out'),
            color: Color.fromARGB(255, 243, 187, 5),
          )
        ],
      )),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Option',
                hintStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kGrayColor),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 26,
            width: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: kGrayColor),
            ),
          )
        ],
      ),
    );
  }
}
