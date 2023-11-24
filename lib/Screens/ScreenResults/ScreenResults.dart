import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus/Core/Colors.dart';
import 'package:ibus/Core/Widgets/GContainer.dart';

class ScreenResults extends StatefulWidget {
  const ScreenResults({super.key});

  @override
  State<ScreenResults> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const GContainer(text: "Buses Found!"),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: ListTile(
                      leading: const Text(
                        "🚍  ",
                        style: TextStyle(fontSize: 23),
                      ),
                      title: Text(" $index"),
                      subtitle: const Text("wassup?"),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(
                height: 10,
              ),
              itemCount: 15,
            ),
          ),
        ],
      )),
    );
  }
}
