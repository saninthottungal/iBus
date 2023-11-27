import 'package:flutter/material.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';

class ScreenGreet extends StatefulWidget {
  const ScreenGreet({super.key});

  @override
  State<ScreenGreet> createState() => _ScreenGreetState();
}

class _ScreenGreetState extends State<ScreenGreet> {
  late final TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GContainer(text: "Hi There,\nWhat should we\ncall you..?"),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                maxLength: 10,
                controller: nameController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_3_outlined),
                  hintStyle: TextStyle(color: Colors.black38),
                  hintText: "eg : Mark",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isEmpty) {
                    SnaackBar.showSnaackBar(
                        context, "Name cannot be empty !", snackRed);
                  } else if (nameController.text.isNotEmpty) {
                    SnaackBar.showSnaackBar(
                        context, "Name Saved !", snackGreen);

                    //ScreenAuth Route

                    Navigator.of(context).pushReplacementNamed("signin");
                  } else {
                    SnaackBar.showSnaackBar(
                        context, "Unknown Error Occured !", snackRed);
                  }
                },
                child: const Text("Go !"),
              ),
            ),

            //remove
          ],
        ),
      ),
    );
  }
}
