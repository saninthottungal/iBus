import 'package:flutter/material.dart';
import 'package:ibus2/core/GContainer.dart';

class ScreenAdmin extends StatelessWidget {
  const ScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [GContainer(text: "Add")],
      ),
    );
  }
}
