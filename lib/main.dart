import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus/Core/Colors.dart';
import 'package:ibus/Screens/ScreenAuth/ScreenSignIn.dart';
import 'package:ibus/Screens/ScreenAuth/ScreenSignUp.dart';
import 'package:ibus/Screens/ScreenGreet/ScreenGreet.dart';
import 'package:ibus/Screens/ScreenHome/ScreenHome.dart';
import 'package:ibus/Screens/ScreenResults/ScreenResults.dart';

main() {
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      ),
      home: const ScreenGreet(),
      routes: {
        "signin": (context) => const ScreenSignIn(),
        "signup": (context) => const ScreenSignUp(),
        "greet": (context) => const ScreenGreet(),
        "home": (context) => const ScreenHome(),
        "results": (context) => const ScreenResults(),
      },
    );
  }
}
