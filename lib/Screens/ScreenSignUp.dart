import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibus2/Screens/ScreenSignin.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSignUp extends StatelessWidget {
  ScreenSignUp({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          //custom container

          const GContainer(text: "Let's SignUp,\n     Shall We?"),
          const SizedBox(height: 60),

          //email text field

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

          //password text field

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              obscureText: true,
              obscuringCharacter: '*',
              controller: passwordController,
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

          //elevated Button

          ElevatedButton(
            onPressed: () async {
              final email = emailController.text;
              final password = passwordController.text;
              if (email.trim().isEmpty || password.trim().isEmpty) {
                SnaackBar.showSnaackBar(
                    context, "E-mail or Password Cannot be Empty", snackRed);
                return;
              }
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, password: password);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  SnaackBar.showSnaackBar(context,
                      "Password Must be atleast 6 Characters", snackRed);
                  return;
                } else if (e.code == 'invalid-email') {
                  SnaackBar.showSnaackBar(context, "Invalid E-mail", snackRed);
                  return;
                } else if (e.code == 'email-already-in-use') {
                  SnaackBar.showSnaackBar(
                      context, "E-Mail Already in Use", snackRed);
                  return;
                } else {
                  SnaackBar.showSnaackBar(
                      context, "An Unknown Error Expected", snackRed);
                  return;
                }
              } catch (_) {
                SnaackBar.showSnaackBar(
                    context, "An Unknown Error Expected", snackRed);
                return;
              }

              final sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(sharedKey, true);

              SnaackBar.showSnaackBar(
                  context, "Succesfully Signed Up", snackGreen);
              Navigator.of(context).pushReplacementNamed('home');
            },
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 100),

          //Navigator to signin

          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ScreenSignIn()));
              },
              child: const Text(
                "Already Have An Account?\nSign In",
                textAlign: TextAlign.center,
              )),
        ],
      )),
    );
  }
}
