import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashText extends StatelessWidget {
  const SplashText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "iBus",
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 225, 100),
          fontSize: 150,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(2, 2),
                blurRadius: 1),
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(4, 4),
                blurRadius: 1),
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(6, 6),
                blurRadius: 1),
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(8, 8),
                blurRadius: 1),
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(10, 10),
                blurRadius: 1),
            Shadow(
                color: Color.fromARGB(255, 206, 141, 0),
                offset: Offset(12, 12),
                blurRadius: 1),
          ],
        ),
      ),
    );
  }
}
