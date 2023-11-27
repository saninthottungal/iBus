import 'package:flutter/material.dart';
import 'package:ibus2/core/GContainer.dart';

class ScreenBus extends StatelessWidget {
  const ScreenBus({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          GContainer(text: "Bus"),
        ],
      ),
    );
  }
}
