import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ibus2/core/Colors.dart';

class ScreenAdmin extends StatelessWidget {
  const ScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.4,
            decoration: const BoxDecoration(
              color: themeColor,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            fillColor: Colors.white10,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.white70),
                            hintText: "Name",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10)),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white10,
                        filled: true,
                        hintText: "Number",
                        hintStyle: TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.access_alarm),
                      style: const ButtonStyle(
                        //elevation: MaterialStatePropertyAll(10),
                        iconColor: MaterialStatePropertyAll(themeColor),
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                        overlayColor: MaterialStatePropertyAll(Colors.black38),
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   onPressed: () {},
                    //   icon: const Icon(Icons.access_alarm),
                    //   label: const Text("Select Time"),
                    // ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Select Time",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text("Add Bus"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return const Card(
                    child: ListTile(
                      title: Text("data"),
                      subtitle: Text("data"),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}
