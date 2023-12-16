import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:ibus2/Database/DatabaseModel.dart';

final ValueNotifier<List<BusModel>> busNotifier = ValueNotifier([]);

class DatabaseFunctions {
  Future<Box<BusModel>> openDB() async {
    return await Hive.openBox<BusModel>('BusDB');
  }

  Future<void> addBusesFromFirestore() async {
    try {
      final db = await openDB();

      final buses = await FirebaseFirestore.instance
          .collection('Bus')
          .get()
          .then((value) => value.docs);

      await Future.forEach(buses, (bus) async {
        final busObject = BusModel.fromFirestore(bus);
        await db.add(busObject);
      });

      getAllBuses();
    } on FirebaseException catch (_) {
      throw FirebaseException(plugin: "");
    } on PlatformException catch (_) {
      throw PlatformException(code: "code");
    } on Exception catch (_) {
      throw Exception();
    }
  }

  Future<void> getAllBuses() async {
    busNotifier.value.clear();
    final db = await openDB();
    final listOfBus = db.values.toList();
    busNotifier.value.addAll(listOfBus);
  }
}
