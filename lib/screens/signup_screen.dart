import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:animate_do/animate_do.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isConfirmPasswordObscure = true;

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
                              "Sign up",
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
                              "Welcome! Here you can create an account.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
                                  height: 60,
                                ),
                                FadeInUp(
                                    duration: Duration(milliseconds: 1400),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    225, 95, 27, .3),
                                                blurRadius: 20,
                                                offset: Offset(10, 10))
                                          ]),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200)),
                                            ),
                                            child: TextField(
                                              controller: _emailController,
                                              decoration: InputDecoration(
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.email_outlined,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200)),
                                            ),
                                            child: TextField(
                                              obscureText: _isObscure,
                                              controller: _passwordController,
                                              decoration: InputDecoration(
                                                hintText: "Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.lock_outline,
                                                    color: Colors.grey,
                                                  ),
                                                ),
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
                                          Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors
                                                          .grey.shade200)),
                                            ),
                                            child: TextField(
                                              obscureText:
                                                  _isConfirmPasswordObscure,
                                              controller:
                                                  _confirmpasswordController,
                                              decoration: InputDecoration(
                                                hintText: "Confirm Password",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Icon(
                                                    Icons.lock_outline,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _isConfirmPasswordObscure =
                                                          !_isConfirmPasswordObscure;
                                                    });
                                                  },
                                                  child: Icon(
                                                    _isConfirmPasswordObscure
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
                                  height: 40,
                                ),
                                FadeInUp(
                                    duration: Duration(milliseconds: 1600),
                                    child: MaterialButton(
                                      onPressed: () {
                                        signUp();
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
                                          "Sign up",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                SizedBox(
                                  height: 60,
                                ),
                                // already have an account
                                FadeInUp(
                                    duration: Duration(milliseconds: 1700),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Already have an account?",
                                          style: GoogleFonts.robotoCondensed(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            openSigninScreen();
                                          },
                                          child: Text(
                                            " Sign in",
                                            style: GoogleFonts.robotoCondensed(
                                                color: Colors.deepPurple,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        )
                                      ],
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                ])));
  }
}
