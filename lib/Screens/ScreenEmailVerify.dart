import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibus2/Screens/ScreenHome.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/GContainer.dart';
import 'package:ibus2/core/SnaackBar.dart';

class ScreenEmailVerify extends StatefulWidget {
  const ScreenEmailVerify({super.key});

  @override
  State<ScreenEmailVerify> createState() => _ScreenEmailVerifyState();
}

class _ScreenEmailVerifyState extends State<ScreenEmailVerify> {
  bool _isEmailVerified = false;
  Timer? _timer;

  @override
  void initState() {
    _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!_isEmailVerified) {
      sendEmailVerification();

      _timer = Timer.periodic(const Duration(seconds: 3), (_) {
        checkEmailVerified();
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEmailVerified) {
      return const ScreenHome();
    } else {
      return Scaffold(
        body: Column(
          children: [
            const GContainer(text: "Please Check \n      Youe Mail 📬"),
            const SizedBox(
              height: 75,
              width: double.infinity,
            ),
            const Text(
              "A verfication E-mail will be \nsent to your current Mail ID.\nplease verify it.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeColor,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            const Text(
              "didn't recieve the mail?",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: snackRed,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
              width: double.infinity,
            ),
            SizedBox(
              width: 250,
              child: ElevatedButton.icon(
                onPressed: sendEmailVerification,
                icon: const Icon(Icons.mail_outline_outlined),
                label: const Text(
                  "Re-send",
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      // user.reload();
    } on FirebaseAuthException catch (_) {
      SnaackBar.showSnaackBar(context, "Couldn't send E-mail", snackRed);
      return;
    } on FirebaseException catch (_) {
      SnaackBar.showSnaackBar(context, "Couldn't find user", snackRed);
      return;
    } catch (_) {
      SnaackBar.showSnaackBar(context, "Unknown error occured", snackRed);
    }
    SnaackBar.showSnaackBar(context, "E-mail sent", snackGreen);
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      _isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (_isEmailVerified) {
      _timer?.cancel();
    }
  }
}
