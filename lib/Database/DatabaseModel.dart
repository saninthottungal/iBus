import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/adapters.dart';
part 'DatabaseModel.g.dart';

@HiveType(typeId: 1)
class BusModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String number;
  @HiveField(3)
  final DateTime time;

  BusModel({
    required this.id,
    required this.name,
    required this.number,
    required this.time,
  });

  static BusModel fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> bus) {
    Timestamp time = bus['time'];
    DateTime formattedTime = time.toDate();

    return BusModel(
        id: bus.id,
        name: bus['name'],
        number: bus['number'],
        time: formattedTime);
  }
}
