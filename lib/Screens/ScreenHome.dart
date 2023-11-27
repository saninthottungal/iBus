import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/core/Colors.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //stack

            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: height * 0.4,
                  decoration: const BoxDecoration(
                    color: themeColor,
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),

                      //Hi there and Profile

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Hi Sanin,",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(210, 255, 255, 255),
                                fontSize: 29,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.person_3_outlined),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    //text Field 1

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(100, 100, 91, 100),
                            hintStyle: TextStyle(color: Colors.white60),
                            hintText: "Where Are You Now?",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.close_outlined,
                                color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //text Field 2

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(100, 100, 91, 100),
                            hintStyle: TextStyle(color: Colors.white60),
                            hintText: "Where Are You Going?",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.close_outlined,
                                color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              ],
            ),

            //available Dates

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Available Dates",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                    label: Text("Today"),
                    labelStyle: TextStyle(color: Color.fromARGB(255, 7, 43, 8)),
                    selected: true,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("Tomorrow"),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("22nd"),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("Other"),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
              ],
            ),
            const SizedBox(height: 30),

            // Preferred Time

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Preffered Time",
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                    label: Text("Now"),
                    labelStyle: TextStyle(color: Color.fromARGB(255, 7, 43, 8)),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("Morning"),
                    selected: true,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("Noon"),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
                ChoiceChip(
                    label: Text("Custom"),
                    selected: false,
                    selectedColor: Colors.green,
                    showCheckmark: false,
                    shape: StadiumBorder()),
              ],
            ),
            const SizedBox(height: 40),

            //elevated find bus Button
            SizedBox(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text("Find Buses"))),

            //remove
          ],
        ),
      ),
    );
  }
}
