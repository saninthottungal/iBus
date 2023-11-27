import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/core/Colors.dart';

class GContainer extends StatelessWidget {
  final String text;
  const GContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.4,
      decoration: const BoxDecoration(
        color: themeColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "🚍 $text",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(210, 255, 255, 255),
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
