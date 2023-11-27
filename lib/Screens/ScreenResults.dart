import 'package:flutter/material.dart';
import 'package:ibus2/core/GContainer.dart';

class ScreenResults extends StatefulWidget {
  const ScreenResults({super.key});

  @override
  State<ScreenResults> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ScreenResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const GContainer(text: "Buses Found!"),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('bus');
                      },
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

          //removeeeeee
        ],
      ),
    );
  }
}
