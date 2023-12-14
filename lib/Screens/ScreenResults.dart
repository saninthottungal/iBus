import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibus2/Database/DatabaseFunctions.dart';
import 'package:ibus2/core/Colors.dart';

class ScreenResults extends StatelessWidget {
  const ScreenResults({
    super.key,
    required String fromLocation,
    required String toLocation,
    required DateTime selectedDateTime,
  })  : _selectedDateTime = selectedDateTime,
        _toLocation = toLocation,
        _fromLocation = fromLocation;

  final String _fromLocation;
  final String _toLocation;
  final DateTime _selectedDateTime;

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
              padding: const EdgeInsets.only(
                  top: 80, left: 15, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    " 🚍 $_fromLocation",
                    // textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    " 🚍 $_toLocation",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    " 🚍 ${_selectedDateTime.day}-${_selectedDateTime.month}-${_selectedDateTime.year}",
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
          FutureBuilder(
              future: DatabaseFunctions().getBuses(_selectedDateTime),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
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
                                "🚍 ",
                                style: TextStyle(fontSize: 23),
                              ),
                              title: Text(
                                snapshot.data!.elementAt(index).name!,
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: themeColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              subtitle:
                                  Text(snapshot.data!.elementAt(index).regNum!),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  snapshot.data!.elementAt(index).start!,
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) => const SizedBox(
                        height: 10,
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),

          //removeeeeee
        ],
      ),
    );
  }
}
