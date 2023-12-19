import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/core/Colors.dart';
import 'package:ibus2/core/Constants.dart';
import 'package:intl/intl.dart';

class ScreenBus extends StatelessWidget {
  const ScreenBus({
    super.key,
    required this.busName,
    required this.busNumber,
    required this.time,
    required this.whereFrom,
    required this.whereTo,
  });

  final String busName;
  final String busNumber;
  final DateTime time;
  final String whereFrom;
  final String whereTo;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.4,
          decoration: const BoxDecoration(
            color: themeColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 80, left: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " 🚍 $busName",
                  // textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 225, 100),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "   🚍 $busNumber",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  "   🚍 ${DateFormat('hh:mm a').format(time)}",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 10),
          child: FutureBuilder(
              future: getRoutes(),
              builder: (context, snapshot) {
                return ListView.builder(
                  itemBuilder: (ctx, index) {
                    if (index == 0) {
                      return ListTile(
                        leading: const Text(
                          "🚍",
                          style: TextStyle(fontSize: 20),
                        ),
                        title: Text(
                          snapshot.data![index],
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: themeColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Text(
                          DateFormat('hh:mm a').format(time),
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else if (index == snapshot.data!.length - 1) {
                      return ListTile(
                        leading: const Icon(
                          Icons.location_on_rounded,
                          color: Colors.green,
                        ),
                        title: Text(
                          snapshot.data![index],
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: themeColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Text(
                          DateFormat('hh:mm a').format(time.add(
                              Duration(minutes: snapshot.data!.length * 2))),
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListTile(
                        leading: const Padding(
                          padding: EdgeInsets.only(left: 4),
                          child: Icon(
                            Icons.move_down_outlined,
                            size: 22,
                            color: themeColor,
                          ),
                        ),
                        title: Text(
                          snapshot.data![index],
                          style: const TextStyle(fontSize: 17),
                        ),
                        trailing: Text(
                          DateFormat('hh:mm').format(
                            time.add(
                              Duration(minutes: index * 2),
                            ),
                          ),
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }
                  },
                  itemCount: snapshot.data!.length,
                );
              }),
        )),
      ],
    ));
  }

  Future<List<String>> getRoutes() async {
    const localPlaces = places;
    List<String> formattedPlaces = [];
    final indexFrom = localPlaces.indexOf(whereFrom);
    final indexTo = localPlaces.indexOf(whereTo);
    if (indexFrom < indexTo) {
      for (int i = indexFrom; i <= indexTo; i++) {
        formattedPlaces.add(localPlaces[i]);
      }
    } else {
      for (int i = indexFrom; i >= indexTo; i--) {
        formattedPlaces.add(localPlaces[i]);
      }
    }
    return formattedPlaces;
  }
}
