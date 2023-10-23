import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  Future signUp() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmpasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: 'Textfields are empty! Please fill all the fields.',
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
      return;
    }

    if (passConfirmed()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        // Save user data in Firestore
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.uid)
            .set({
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
          'uid': userCredential.user!.uid,

          // Add more user data fields as needed
        });

        Navigator.of(context).pushNamed('/');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');

          // ignore: use_build_context_synchronously
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: 'The password provided is too weak.',
            btnOkColor: Colors.red,
            btnOkOnPress: () {},
          ).show();
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');

          // ignore: use_build_context_synchronously
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            showCloseIcon: true,
            title: 'The account already exists for that email.',
            btnOkColor: Colors.red,
            btnOkOnPress: () {},
          ).show();
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  bool passConfirmed() {
    if (_passwordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: 'Passwords do not match',
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
    }
    return false;
  }

  void openSignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  void openSigninScreen() {
    Navigator.of(context).pushReplacementNamed('loginScreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                'images/welcome.png',
                height: 300,
              ),
              Text(
                'Sign up',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                'Welcome! Here you can create an account.',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 15,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _confirmpasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: signUp,
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Sign up',
                    style: GoogleFonts.robotoCondensed(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already a member? '),
                  GestureDetector(
                    onTap: openSigninScreen,
                    child: Text(
                      'Sign in here',
                      style: GoogleFonts.robotoCondensed(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
