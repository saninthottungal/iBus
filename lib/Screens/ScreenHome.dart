import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:ibus2/core/date.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  late final String displayName;
  ValueNotifier<Date> currentDateNotifier = ValueNotifier(Date.today);
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    displayName = user?.displayName ?? 'User3412';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                            "Hi $displayName😀",
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
                              onPressed: () {
                                //pop up button

                                showMenu(
                                  color:
                                      const Color.fromARGB(255, 57, 209, 156),
                                  context: context,
                                  position:
                                      RelativeRect.fromLTRB(width, 0, 70, 0),
                                  items: [
                                    PopupMenuItem(
                                      onTap: () async {
                                        final sharedPref =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPref.setBool(sharedKey, false);
                                        await FirebaseAuth.instance.signOut();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'signin', (route) => false);
                                      },
                                      child: const Text("Log Out"),
                                    ),
                                  ],
                                );
                              },
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
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(100, 100, 91, 100),
                          hintStyle: TextStyle(color: Colors.white60),
                          hintText: "Where Are You Now?",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //text Field 2

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(100, 100, 91, 100),
                          hintStyle: TextStyle(color: Colors.white60),
                          hintText: "Where Are You Going?",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                )
              ],
            ),

            const SizedBox(height: 30),

            // ListView.separated(
            //   itemBuilder: (context, index) {
            //     return const ListTile(
            //       title: Text("sanin"),
            //     );
            //   },
            //   separatorBuilder: (context, index) => const SizedBox(height: 2),
            //   itemCount: 1,
            // ),

            //available Dates

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Select Date",
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

            const SizedBox(height: 15),

            //radiossss

            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ValueListenableBuilder(
                  valueListenable: currentDateNotifier,
                  builder: (context, newDate, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: Date.today,
                                groupValue: newDate,
                                onChanged: (newValue) {
                                  currentDateNotifier.value = newValue!;
                                }),
                            const Text(
                              "Today",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Date.tomorrow,
                                groupValue: newDate,
                                onChanged: (newValue) {
                                  currentDateNotifier.value = newValue!;
                                }),
                            const Text(
                              "Tomorrow",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: Date.custom,
                                groupValue: newDate,
                                onChanged: (newValue) async {
                                  selectedDate = await customDate(context);
                                  currentDateNotifier.value = newValue!;
                                }),
                            const Text(
                              "Custom",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: themeColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            ),

            const SizedBox(height: 30),

            ValueListenableBuilder(
                valueListenable: currentDateNotifier,
                builder: (context, newValue, _) {
                  if (newValue == Date.today) {
                    selectedDate = DateTime.now();
                  } else if (newValue == Date.tomorrow) {
                    selectedDate = DateTime.now().add(const Duration(days: 1));
                  } else {}
                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        "Preferred Date : ${dateParser(selectedDate)}",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            color: themeColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }),

            // Preferred Time

            const SizedBox(height: 40),

            //elevated find bus Button
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pushNamed('results');
                },
                child: const Text("Find Buses"),
              ),
            ),

            //remove
          ],
        ),
      ),
    );
  }

  String dateParser(DateTime value) {
    final dateTime = '${value.day}th - ${value.month} - ${value.year}';
    return dateTime;
  }

  Future<DateTime> customDate(BuildContext context) async {
    final dateTime = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 30 * 10),
      ),
    );
    if (dateTime == null) {
      return DateTime.now();
    } else {
      return dateTime;
    }
  }
}
