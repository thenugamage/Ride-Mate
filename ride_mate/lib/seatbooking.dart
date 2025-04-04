import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for DateFormat

class SeatBookingPage extends StatelessWidget {
  final String travelCompany;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final dynamic bus; // Pass the bus object if needed

  const SeatBookingPage({
    super.key,
    required this.travelCompany,
    required this.origin,
    required this.destination,
    required this.dateTime,
    required this.bus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Booking'),
      ),
      body: Center(
        child: Text(
          'Booking for $travelCompany\n'
          'From $origin to $destination\n'
          'Date: ${DateFormat('yyyy-MM-dd').format(dateTime)}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
