import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';

// ignore: must_be_immutable
class ScreenVerifyAdmin extends StatelessWidget {
  ScreenVerifyAdmin({super.key});

  final pvtController = TextEditingController();
  bool isAdmin = false;
  bool isPassword = false;

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
                if (pvtController.text.isEmpty) {
                  SnaackBar.showSnaackBar(
                      context, "Please enter the pvt code", snackRed);

                  return;
                }
                try {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) {
                      return FutureBuilder(
                          future: checkAdmin(ctx),
                          builder: (
                            context,
                            AsyncSnapshot snapshot,
                          ) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return const AlertDialog(
                                  title: Text(
                                    "Erro 404",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                );

                              case ConnectionState.waiting:
                                return const AlertDialog(
                                  title: Text(
                                    "Verifying Admin",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                );

                              case ConnectionState.active:
                                return const AlertDialog(
                                  title: Text(
                                    "Verifying Admin",
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                    ],
                                  ),
                                );

                              case ConnectionState.done:
                                if (isAdmin && isPassword) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Admin Verified",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      "Press Enter to \n Access Admin page",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                            Navigator.of(context)
                                                .pushReplacementNamed('admin');
                                          },
                                          child: const Text("Enter")),
                                      const SizedBox(width: 65),
                                    ],
                                  );
                                } else {
                                  return AlertDialog(
                                    title: const Text(
                                      "Couldn't Verify Admin ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      "Unauthorized access to \nAdmin page denied",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(ctx);
                                          },
                                          child: const Text("Ok")),
                                      const SizedBox(width: 80),
                                    ],
                                  );
                                }
                            }
                          });
                    },
                  );
                } on Exception catch (_) {
                  Navigator.of(context);
                  SnaackBar.showSnaackBar(
                      context, "Couldn't verify admin", snackRed);
                }
              },
              child: const Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkAdmin(BuildContext context) async {
    try {
      //getting logged in user from firebase
      final user = FirebaseAuth.instance.currentUser;

      //getting admins list from Firestore
      final adminsCollection =
          await FirebaseFirestore.instance.collection('admins').get();

      final Iterable<String> admins = adminsCollection.docs.map((doc) {
        return doc['mail'];
      });

      for (String admin in admins) {
        if (admin == user!.email) {
          isAdmin = true;
        }
      }

      //getting password from firestore

      final passwordCollection =
          await FirebaseFirestore.instance.collection('password').get();

      final passwords = passwordCollection.docs.map((password) {
        return password['pvtcode'];
      });

      for (final pass in passwords) {
        if (pvtController.text.trim() == pass) {
          isPassword = true;
        }
      }
    } on FirebaseException catch (_) {
      throw Exception();
    } catch (_) {
      throw Exception();
    }
  }
}
