import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/Screens/ScreenResults.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:ibus2/core/SnaackBar.dart';
import 'package:ibus2/core/date.dart';
import 'package:ibus2/core/fieldEnum.dart';
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

  ValueNotifier<List<String>> placeListNotifier = ValueNotifier([]);

  String? whereFrom;
  String? whereTo;

  field whichField = field.field1;

  final fromController = TextEditingController();
  final toController = TextEditingController();

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    displayName = user?.displayName ?? 'User3412';
    super.initState();
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
                                color: const Color.fromARGB(255, 57, 209, 156),
                                context: context,
                                position:
                                    RelativeRect.fromLTRB(width, 0, 70, 0),
                                items: [
                                  PopupMenuItem(
                                    onTap: () async {
                                      try {
                                        final sharedPref =
                                            await SharedPreferences
                                                .getInstance();
                                        sharedPref.setBool(sharedKey, false);
                                        await FirebaseAuth.instance.signOut();
                                      } on FirebaseAuthException catch (_) {
                                        SnaackBar.showSnaackBar(
                                            context,
                                            "An unknown Error Occured",
                                            snackRed);
                                        return;
                                      } catch (_) {
                                        SnaackBar.showSnaackBar(
                                            context,
                                            "An unknown Error Occured",
                                            snackRed);
                                        return;
                                      }
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              'signin', (route) => false);
                                      SnaackBar.showSnaackBar(context,
                                          "Logout Succesful", snackGreen);
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

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ValueListenableBuilder(
                        valueListenable: placeListNotifier,
                        builder: (context, newvalue, _) {
                          return TextField(
                            controller: fromController,
                            onTap: () {
                              whichField = field.field1;

                              placeListNotifier.value.addAll(places);
                            },
                            onChanged: (value) => filterResults(value),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(100, 100, 91, 100),
                              hintStyle: const TextStyle(color: Colors.white70),
                              hintText: whereFrom ?? "Where Are You Now ?",
                              border: const OutlineInputBorder(),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //text Field 2

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ValueListenableBuilder(
                        valueListenable: placeListNotifier,
                        builder: (context, newValue, _) {
                          return TextField(
                            controller: toController,
                            onTap: () {
                              whichField = field.field2;
                              // print(whichField.toString());
                              placeListNotifier.value = places;
                            },
                            onChanged: (value) => filterResults(value),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(100, 100, 91, 100),
                              hintStyle: const TextStyle(color: Colors.white70),
                              hintText: whereTo ?? "Where Are You Going?",
                              border: const OutlineInputBorder(),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 30),
                ],
              )
            ],
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
              child: ValueListenableBuilder(
                  valueListenable: placeListNotifier,
                  builder: (context, newValue, _) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(
                              newValue[index],
                              textAlign: TextAlign.left,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: themeColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            onTap: () {
                              if (whichField == field.field1) {
                                whereFrom = newValue[index];
                                fromController.clear();

                                placeListNotifier.value = [];
                              } else {
                                whereTo = newValue[index];

                                placeListNotifier.value = [];
                                toController.clear();
                              }
                            },
                            enableFeedback: true,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 2),
                      itemCount: placeListNotifier.value.length,
                    );
                  }),
            ),
          ),

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

          const SizedBox(height: 10),

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
              onPressed: () {
                if (whereFrom == null || whereTo == null) {
                  SnaackBar.showSnaackBar(
                      context, "Please select Locations", snackRed);

                  return;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenResults(
                            fromLocation: whereFrom!,
                            toLocation: whereTo!,
                            selectedDateTime: selectedDate,
                          )));
                }
              },
              child: const Text("Find Buses"),
            ),
          ),

          const SizedBox(height: 110),

          //remove
        ],
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

  void filterResults(String enteredWord) {
    if (enteredWord.isEmpty) {
      placeListNotifier.value = places;
    } else {
      placeListNotifier.value =
          places.where((place) => place.contains(enteredWord)).toList();
    }
  }
}
