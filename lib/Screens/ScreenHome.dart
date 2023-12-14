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
  late final String _displayName;
  final ValueNotifier<Date> _currentDateNotifier = ValueNotifier(Date.today);
  DateTime _selectedDate = DateTime.now();

  final ValueNotifier<List<String>> _placeListNotifier = ValueNotifier([]);

  String? _whereFrom;
  String? _whereTo;

  field _whichField = field.field1;

  final _fromController = TextEditingController();
  final _toController = TextEditingController();

  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    _displayName = user?.displayName ?? 'User3412';
    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
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
                          "Hi $_displayName😀",
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
                                    child: const Text(
                                      "Log Out",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  PopupMenuItem(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed("verifyAdmin");
                                      },
                                      child: const Text(
                                        "Admin?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))
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
                        valueListenable: _placeListNotifier,
                        builder: (context, newvalue, _) {
                          return TextField(
                            controller: _fromController,
                            onTap: () {
                              _whichField = field.field1;

                              _placeListNotifier.value.addAll(places);
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
                              hintText: _whereFrom ?? "Where Are You Now ?",
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
                        valueListenable: _placeListNotifier,
                        builder: (context, newValue, _) {
                          return TextField(
                            controller: _toController,
                            onTap: () {
                              _whichField = field.field2;
                              // print(whichField.toString());
                              _placeListNotifier.value = places;
                            },
                            onChanged: (value) => filterResults(value),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(100, 100, 91, 100),
                              hintStyle: const TextStyle(color: Colors.white70),
                              hintText: _whereTo ?? "Where Are You Going?",
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
                  valueListenable: _placeListNotifier,
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
                              if (_whichField == field.field1) {
                                _whereFrom = newValue[index];
                                _fromController.clear();

                                _placeListNotifier.value = [];
                              } else {
                                _whereTo = newValue[index];

                                _placeListNotifier.value = [];
                                _toController.clear();
                              }
                            },
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 2),
                      itemCount: _placeListNotifier.value.length,
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
                valueListenable: _currentDateNotifier,
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
                                _currentDateNotifier.value = newValue!;
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
                                _currentDateNotifier.value = newValue!;
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
                                _selectedDate = await customDate(context);
                                _currentDateNotifier.value = newValue!;
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
              valueListenable: _currentDateNotifier,
              builder: (context, newValue, _) {
                if (newValue == Date.today) {
                  _selectedDate = DateTime.now();
                } else if (newValue == Date.tomorrow) {
                  _selectedDate = DateTime.now().add(const Duration(days: 1));
                } else {}
                return SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      "Preferred Date : ${dateParser(_selectedDate)}",
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
                if (_whereFrom == null || _whereTo == null) {
                  SnaackBar.showSnaackBar(
                    context,
                    "Please select Locations",
                    snackRed,
                  );

                  return;
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenResults(
                            fromLocation: _whereFrom!,
                            toLocation: _whereTo!,
                            selectedDateTime: _selectedDate,
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
      _placeListNotifier.value = places;
    } else {
      _placeListNotifier.value =
          places.where((place) => place.contains(enteredWord)).toList();
    }
  }
}
