// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ForgotPasswordPage is a StatefulWidget that displays a form with an email field and a button to reset the password.
// When the user taps the button, the _resetPassword method is called.
// This method uses the email address entered by the user to send a password reset email to the user.
// If the email address is valid, the user will receive an email with a link to reset the password.
// If the email address is invalid, the user will receive an error message.
// If the email address is valid and the password reset email is sent successfully, the user will see a success dialog.

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);
  static const routeName = 'forgotPasswordScreen';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late BuildContext dialogContext; // Store the context during build method

  @override
  Widget build(BuildContext context) {
    dialogContext = context; // Store the context here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetPassword,
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetPassword() async {
    String emailText = _emailController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailText);

        // If reset password is successful, show success dialog
        AwesomeDialog(
          context: dialogContext, // Use the stored context here
          dialogType: DialogType.info,
          animType: AnimType.topSlide,
          showCloseIcon: true,
          title: 'Password Reset Email Sent!',
          desc: 'Please check your email to reset your password.',
          btnOkColor: Colors.green,
          btnOkOnPress: () {
            Navigator.of(dialogContext)
                .pop(); // Use dialogContext to close the dialog
          },
        ).show();
      } on FirebaseAuthException catch (e) {
        // Handle Firebase Auth exceptions and show error dialog
        String errorMessage = '';

        if (e.code == 'user-not-found') {
          errorMessage = 'No account found with this email. Please sign up.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Invalid email address. Please check your email.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }

        AwesomeDialog(
          context: dialogContext, // Use the stored context here
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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
