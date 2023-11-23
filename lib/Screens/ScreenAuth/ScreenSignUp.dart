import 'package:flutter/material.dart';
import 'package:ibus/Core/Widgets/GContainer.dart';
import 'package:ibus/Screens/ScreenAuth/ScreenSignIn.dart';

class ScreenSignUp extends StatefulWidget {
  const ScreenSignUp({super.key});

  @override
  State<ScreenSignUp> createState() => _ScreenSignUpState();
}

class _ScreenSignUpState extends State<ScreenSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const GContainer(text: "Let's SignUp,\n     Shall We?"),
          const SizedBox(height: 60),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              decoration: InputDecoration(
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextField(
              decoration: InputDecoration(
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
          ElevatedButton(
            onPressed: () {},
            child: const Text("Sign Up"),
          ),
          const SizedBox(height: 100),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ScreenSignIn()));
              },
              child: const Text(
                "Already Have An Account?\nSign In",
                textAlign: TextAlign.center,
              ))
        ],
      )),
    );
  }
}
