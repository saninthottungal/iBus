import 'package:flutter/material.dart';
import 'package:ibus/Core/Widgets/GContainer.dart';
import 'package:ibus/Screens/ScreenAuth/ScreenSignUp.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          const GContainer(text: "Let's SignIn,\n     Shall We?"),
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
            child: const Text("Sign In"),
          ),
          const SizedBox(height: 100),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ScreenSignUp()));
              },
              child: const Text(
                "New to iBus?\nSign Up",
                textAlign: TextAlign.center,
              ))
        ],
      )),
    );
  }
}
