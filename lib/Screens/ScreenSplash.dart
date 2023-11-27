import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
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
          children: [
            Text(
              "iBus",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  color: Color.fromARGB(210, 255, 255, 255),
                  fontSize: 150,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                "assets/images/pngwing.com.png",
                width: width * 0.38,
              ),
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
  if (value != null) {
    Navigator.of(context).pushReplacementNamed('home');
  } else {
    Navigator.of(context).pushReplacementNamed('signin');
  }
}
