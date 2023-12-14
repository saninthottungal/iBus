import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/SnaackBar.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ScreenAdmin extends StatelessWidget {
  //

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  DateTime? _selectedTime;
  final _formattedTimeNotifier = ValueNotifier<String?>(null);
  final _sortNotifier = ValueNotifier<String>('name');
  //
  ScreenAdmin({super.key});

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
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
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
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: TextField(
                      controller: _numberController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
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
                    const SizedBox(
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
                      onPressed: () async {
                        final now = DateTime.now();
                        final time = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 5, minute: 10));

                        if (time != null) {
                          _selectedTime = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            time.hour,
                            time.minute,
                          );

                          _formattedTimeNotifier.value =
                              "${_selectedTime!.hour} : ${_selectedTime!.minute}";
                        }
                      },
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
                    ValueListenableBuilder(
                        valueListenable: _formattedTimeNotifier,
                        builder: (context, newValue, _) {
                          return Text(
                            newValue ?? "Select Time",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_nameController.text.trim().isEmpty ||
                        _numberController.text.trim().isEmpty) {
                      SnaackBar.showSnaackBar(
                          context, "Name or Number of Bus is Empty", snackRed);
                      return;
                    } else if (_selectedTime == null) {
                      SnaackBar.showSnaackBar(
                          context, "Time is Empty", snackRed);
                      return;
                    }

                    try {
                      CollectionReference buses =
                          FirebaseFirestore.instance.collection('Bus');
                      final name = _nameController.text.trim();
                      final numberwithoutkl =
                          _numberController.text.trim().toUpperCase();

                      final number = "KL $numberwithoutkl ";

                      final time = Timestamp.fromDate(_selectedTime!);
                      final timeNow = Timestamp.fromDate(DateTime.now());
                      await buses.add({
                        'name': name,
                        'number': number,
                        'time': time,
                        'timeAdded': timeNow,
                      });
                      SnaackBar.showSnaackBar(
                          context, "Bus Added!", snackGreen);
                    } on FirebaseException catch (_) {
                      SnaackBar.showSnaackBar(
                          context, "Couldn't add Bus", snackRed);
                    } on PlatformException catch (_) {
                      SnaackBar.showSnaackBar(
                          context, "Couldn't add Bus", snackRed);
                    } catch (_) {
                      SnaackBar.showSnaackBar(
                          context, "Couldn't add Bus", snackRed);
                    }

                    _nameController.clear();
                    _numberController.clear();
                    _formattedTimeNotifier.value = null;
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add Bus"),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 240, top: 5),
            child: Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_sortNotifier.value == 'name') {
                        _sortNotifier.value = 'timeAdded';
                      } else {
                        _sortNotifier.value = 'name';
                      }
                    },
                    child: const Text("Sort")),
                const SizedBox(width: 10),
                ValueListenableBuilder(
                    valueListenable: _sortNotifier,
                    builder: (context, newValue, _) {
                      if (newValue == 'name') {
                        return const Text(
                          "Name",
                          style: TextStyle(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return const Text(
                          "Time\nAdded",
                          style: TextStyle(
                            color: themeColor,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _sortNotifier,
              builder: (context, newValue, _) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Bus')
                            .orderBy(newValue)
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Center(
                                child: Text(
                                  "🚍 No Network Connection",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );

                            case ConnectionState.active:
                              if (!snapshot.hasData || snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    "🚍 No Network Connection",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: Text(
                                    "🚍 No Bus Data Available",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black87,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              Iterable<String> times =
                                  snapshot.data!.docs.map((bus) {
                                Timestamp timeFrom = bus['time'];
                                DateTime time = timeFrom.toDate();
                                String formattedTime =
                                    DateFormat('hh:mm a').format(time);
                                return formattedTime;
                              });

                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onLongPress: () async {
                                        await showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext ctx) {
                                              return AlertDialog(
                                                title: const Text(
                                                  "Delete Bus!",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                content: const Text(
                                                  "Do you really want to \ndelete this bus?",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          final id = snapshot
                                                              .data!
                                                              .docs[index]
                                                              .id;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection('Bus')
                                                              .doc(id)
                                                              .delete();
                                                        } on FirebaseException catch (_) {
                                                          SnaackBar.showSnaackBar(
                                                              ctx,
                                                              "couldn,t delete Bus",
                                                              snackRed);
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        } catch (_) {
                                                          SnaackBar.showSnaackBar(
                                                              ctx,
                                                              "Unknown error occured",
                                                              snackRed);
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        }

                                                        Navigator.of(ctx).pop();
                                                        SnaackBar.showSnaackBar(
                                                            context,
                                                            "Bus deleted",
                                                            snackRed);
                                                      },
                                                      child: const Text(
                                                        "Delete",
                                                        style: TextStyle(
                                                            color: snackRed),
                                                      )),
                                                ],
                                              );
                                            });
                                      },
                                      leading: const Text(
                                        "🚍 ",
                                        style: TextStyle(fontSize: 23),
                                      ),
                                      title: Text(
                                        snapshot.data!.docs[index]['name'],
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: themeColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      subtitle: Text(
                                          snapshot.data!.docs[index]['number']),
                                      trailing: Text(
                                        times.elementAt(index),
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.green,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: snapshot.data!.docs.length,
                              );

                            case ConnectionState.done:
                              return Center(
                                child: Text(
                                  "🚍 No Network Connection",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.black87,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                          }
                        }),
                  ),
                );
              })
        ],
      ),
    );
  }
}
