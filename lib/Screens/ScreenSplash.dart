import 'package:flutter/material.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:ibus2/core/splashText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  final String imagePath = 'assets/images/pngwing.com.png';
  @override
  void initState() {
    checkUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(imagePath), context);
    //final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: themeColor,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: SplashText(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 250),
              child: Image.asset(
                'assets/images/playstore.png',
                scale: 3.5,
              ),
            ),
            SizedBox(
              width: width,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> checkUser(BuildContext context) async {
  await Future.delayed(const Duration(milliseconds: 2000));
  final sharedPref = await SharedPreferences.getInstance();
  final value = sharedPref.getBool(sharedKey);
  if (value == null || value == false) {
    Navigator.of(context).pushReplacementNamed('signin');
  } else {
    Navigator.of(context).pushReplacementNamed('home');
  }
}
