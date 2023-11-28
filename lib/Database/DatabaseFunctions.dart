import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:ibus2/Database/DataModel.dart';

class DatabaseFunctions {
  Future<List<DataModel>> readJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString("assets/ibusdb.json");
    final list = json.decode(jsonData) as List<dynamic>;

    final finalList = list.map((e) => DataModel.fromJson(e)).toList();
    return finalList;
  }
}
