import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';

class ScreenForgotPassword extends StatelessWidget {
  ScreenForgotPassword({super.key});

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(children: [
          const GContainer(text: "Please Enter\n     Your Mail"),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "A password reset mail will be \nsent to your preffered Mail ID.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: themeColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                hintStyle: TextStyle(color: Colors.black45),
                hintText: "Mail",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.isEmpty) {
                SnaackBar.showSnaackBar(
                    context, "Please Enter Your Mail", snackRed);
                return;
              }
              try {
                await FirebaseAuth.instance
                    .sendPasswordResetEmail(email: emailController.text);
              } on FirebaseAuthException catch (e) {
                switch (e.code) {
                  case 'invalid-email':
                    SnaackBar.showSnaackBar(context, "Invalid Email", snackRed);
                    break;
                  case 'user-not-found':
                    SnaackBar.showSnaackBar(
                        context, "User not found", snackRed);
                    break;
                  case 'user-disabled':
                    SnaackBar.showSnaackBar(
                        context, "User is disabled by admin", snackRed);
                    break;
                  case 'too-many-requests':
                    SnaackBar.showSnaackBar(
                        context, "Too may requests. try later", snackRed);
                    break;
                  default:
                    SnaackBar.showSnaackBar(
                        context, "An unknown error occured", snackRed);
                }
              } on PlatformException catch (_) {
                SnaackBar.showSnaackBar(
                    context, "Network error occured", snackRed);
              } catch (_) {
                SnaackBar.showSnaackBar(
                    context, "An unknown error occured", snackRed);
              }
              emailController.clear();
              SnaackBar.showSnaackBar(
                  context, "Reset password mail sent", snackGreen);
            },
            child: const Text("Send"),
          ),
          const SizedBox(
            height: 40,
          ),
        ]),
      ),
    );
  }
}
