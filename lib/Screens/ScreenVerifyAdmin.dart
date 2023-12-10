import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';

class ScreenVerifyAdmin extends StatelessWidget {
  ScreenVerifyAdmin({super.key});

  static const String pvt = "pvtpws564";

  final pvtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GContainer(text: "Please enter the\n     Pvt Admin Code:"),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: pvtController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.key_outlined),
                  hintStyle: TextStyle(color: Colors.black45),
                  hintText: "pvt code",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;

                if (user == null) {
                  SnaackBar.showSnaackBar(
                      context, "User does not exist", snackRed);
                  return;
                }

                if (user.email == 'ceosanin564@gmail.com' ||
                    user.email == 'saninthottungalhere@gmail.com') {
                  if (pvtController.text.isNotEmpty) {
                    if (pvtController.text.trim() == pvt) {
                      Navigator.of(context).pushReplacementNamed("admin");
                    } else {
                      SnaackBar.showSnaackBar(
                          context, "Entered Pvt does not match", snackRed);
                    }
                  } else {
                    SnaackBar.showSnaackBar(
                        context, "please enter Pvt code", snackRed);
                  }
                } else {
                  SnaackBar.showSnaackBar(
                      context, "current user is not an Admin", snackRed);
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }
}
