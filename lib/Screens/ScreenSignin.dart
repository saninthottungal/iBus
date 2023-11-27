import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibus2/Screens/ScreenSignUp.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSignIn extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ScreenSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          //container

          const GContainer(text: "Let's SignIn,\n     Shall We?"),
          const SizedBox(height: 60),

          //mail textfield

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.mail_outline),
                hintStyle: TextStyle(color: Colors.black45),
                hintText: "Mail",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          //password textfield

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.key_outlined),
                hintStyle: TextStyle(color: Colors.black45),
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
            width: double.infinity,
          ),

          //elevated button

          ElevatedButton(
            onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;
              if (email.trim().isEmpty || password.trim().isEmpty) {
                SnaackBar.showSnaackBar(
                    context, "E-mail or Password cannot be Empty", snackRed);
                return;
              }
              print("sanin");
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'invalid-email') {
                  SnaackBar.showSnaackBar(context, "Invalid E-mail", snackRed);
                  return;
                } else if (e.code == 'invalid-credential') {
                  SnaackBar.showSnaackBar(
                      context, "Invalid User Credentials", snackRed);
                  return;
                } else {
                  SnaackBar.showSnaackBar(
                      context, "An Unknown Error Occured", snackRed);
                  return;
                }
              } catch (_) {
                SnaackBar.showSnaackBar(
                    context, "An Unknown Error Occured", snackRed);
                return;
              }

              final sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(sharedKey, true);

              SnaackBar.showSnaackBar(context, "Login Successful", snackGreen);
              Navigator.of(context).pushReplacementNamed('home');
            },
            child: const Text("Sign In"),
          ),
          const SizedBox(height: 100),

          //text button

          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ScreenSignUp()));
              },
              child: const Text(
                "New to iBus?\nSign Up",
                textAlign: TextAlign.center,
              )),
        ],
      )),
    );
  }
}
