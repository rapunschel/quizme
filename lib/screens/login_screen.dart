// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables
// These libraries provide the functionality needed to interact with the Firebase Auth service,
// create the UI for the login screen, and show AwesomeDialog dialog boxes.

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizme/screens/forgot_password_page.dart';
import 'package:animate_do/animate_do.dart';
import 'package:community_material_icon/community_material_icon.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

// The code declares variables for the email and password controllers. These controllers will be used to get the user's input.
class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscure = true; // Declare _isObscure variable

  // The signIn() method is used to sign in the user using the email and password entered in the textfields.
  // The method uses the signInWithEmailAndPassword() method from the FirebaseAuth class to sign in the user.
  // If the sign-in is successful, the user is navigated to the next screen.
  // If the sign-in fails, an error dialog is shown using AwesomeDialog.
  // The error dialog shows a different message depending on the error code returned by the FirebaseAuthException.

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
        btnOkColor: Colors.orange[900],
        btnOkOnPress: () {},
      ).show();
    } else {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailText,
          password: passwordText,
        );
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
        // The signIn() function also handles errors that may occur while signing in the user.
        // If an error occurs, then the function shows an AwesomeDialog dialog box with the error message.

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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange.shade900,
          Colors.orange.shade800,
          Colors.orange.shade400
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Sign In",
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.white,
                            fontSize: 40,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1300),
                      child: Text(
                        "Welcome back! Nice to see you again.",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1400),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: Colors.grey,
                                        ),
                                        hintText: "Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                      ),
                                    ),
                                    child: TextField(
                                      obscureText: _isObscure,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock_outline, // Password icon
                                          color: Colors.grey,
                                        ),
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                          child: Icon(
                                            _isObscure
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .end, // Align the text to the right
                          children: <Widget>[
                            FadeInUp(
                              duration: Duration(
                                  milliseconds:
                                      2100), // Adjust the duration as needed
                              child: GestureDetector(
                                child: Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                    // Add an underline decoration
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, ForgotPasswordPage.routeName);
                                },
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: 40,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: MaterialButton(
                              onPressed: () {
                                signIn();
                              },
                              height: 50,
                              // margin: EdgeInsets.symmetric(horizontal: 50),
                              color: Colors.orange[900],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              // decoration: BoxDecoration(
                              // ),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),

                        SizedBox(
                          height: 40,
                        ),

                        // devider
                        FadeInUp(
                            duration: Duration(milliseconds: 1700),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  "  Or  ",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1700),
                            child: Text(
                              "Continue with",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeInUp(
                                duration: Duration(milliseconds: 1800),
                                child: MaterialButton(
                                  onPressed: () {
                                    // Add your Facebook button onPressed logic here
                                  },
                                  height: 50,
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.facebook, // Facebook icon
                                        color: Colors.white,
                                      ),
                                      // Adjust the spacing between the icon and text
                                      SizedBox(width: 1),

                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FadeInUp(
                                duration: Duration(milliseconds: 1900),
                                child: MaterialButton(
                                  onPressed: () {
                                    // Add your Apple button onPressed logic here
                                  },
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.black,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Apple icon
                                      Icon(
                                        Icons.apple,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                          width:
                                              5), // Adjust the spacing between the icon and text
                                      Text(
                                        "Apple",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: FadeInUp(
                                duration: Duration(milliseconds: 2000),
                                child: MaterialButton(
                                  onPressed: () {
                                    // Add your Google button onPressed logic here
                                  },
                                  height: 50,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CommunityMaterialIcons
                                            .google, // Google icon

                                        // Google icon, you can change to a different icon from the Icons class if needed
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                          width:
                                              1), // Adjust the spacing between the icon and text
                                      Text(
                                        "Google",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        FadeInUp(
                          duration: const Duration(
                              milliseconds:
                                  2200), // Adjust the duration as needed
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account? '),
                              GestureDetector(
                                onTap: openSignupScreen,
                                child: Text(
                                  'Sign up here',
                                  style: GoogleFonts.robotoCondensed(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
