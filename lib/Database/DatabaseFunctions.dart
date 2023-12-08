import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:ibus2/Database/DataModel.dart';

class DatabaseFunctions {
  final List<DataModel> finalBuses = [];
  Future<List<DataModel>?> readJsonData() async {
    try {
      final jsonData =
          await rootBundle.rootBundle.loadString("assets/ibusdb.json");
      final list = json.decode(jsonData) as List<dynamic>;
      final finalList = list.map((e) => DataModel.fromJson(e)).toList();
      return finalList;
    } catch (_) {
      return null;
    }
  }

  Future<List<DataModel>?> getBuses(DateTime dateTime) async {
    final buses = await readJsonData();
    if (buses == null) {
      return null;
    } else if (dateTime.day != DateTime.now().day) {
      return buses;
    } else {
      final timeHourNow = DateTime.now().hour;

      await Future.forEach(buses, (element) {
        final subBus = element.start!.substring(0, 2);
        final parsedBus = int.tryParse(subBus) ?? 0;
        if (parsedBus > timeHourNow) {
          finalBuses.add(element);
        }
      });
      return finalBuses;
    }
  }
}
