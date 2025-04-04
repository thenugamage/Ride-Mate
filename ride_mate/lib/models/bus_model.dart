import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  final String id;
  final String origin;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final DateTime date;

  Bus({
    required this.id,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'date': date,
    };
  }

  factory Bus.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Bus(
      id: doc.id,
      origin: data['origin'],
      destination: data['destination'],
      departureTime: (data['departureTime'] as Timestamp).toDate(),
      arrivalTime: (data['arrivalTime'] as Timestamp).toDate(),
      date: (data['date'] as Timestamp).toDate(),
    );
  }
}
