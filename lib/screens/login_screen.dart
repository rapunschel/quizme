import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIn() async {
    String emailText = _emailController.text.trim();
    String passwordText = _passwordController.text.trim();

    if (emailText.isEmpty || passwordText.isEmpty) {
      // Show error dialog if either email or password textfield is empty
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        showCloseIcon: true,
        title: 'Textfields empty! Please insert email and password.',
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailText,
          password: passwordText,
        );

        // If sign-in is successful, you can navigate to the next screen or perform other actions.
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';

        if (e.code == 'user-not-found') {
          errorMessage = 'No account found with this email. Please sign up.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address. Please check your email.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }

        // Show error dialog using AwesomeDialog
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: errorMessage,
          btnOkColor: Colors.red,
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  void openSignupScreen() {
    Navigator.of(context).pushReplacementNamed('signupScreen');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                'Sign in',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                'Welomce back! Nice to see you again.',
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
              GestureDetector(
                onTap: signIn,
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Sign in',
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
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.deepPurple,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account? '),
                  GestureDetector(
                    onTap: openSignupScreen,
                    child: Text(
                      'Sign up',
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
