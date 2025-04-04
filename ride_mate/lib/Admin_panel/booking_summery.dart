import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/providers/booking_provider.dart';
import 'package:ride_mate/models/booking_model.dart';
import 'package:intl/intl.dart';

class BookingsSummeryScreen extends StatefulWidget {
  const BookingsSummeryScreen({super.key});

  @override
  State<BookingsSummeryScreen> createState() => _BookingsSummeryScreenState();
}

class _BookingsSummeryScreenState extends State<BookingsSummeryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingsProvider>(context, listen: false).loadSampleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings Summary'),
        backgroundColor: Colors.yellow,
      ),
      body: Consumer<BookingsProvider>(
        builder: (context, bookingsProvider, child) {
          if (bookingsProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (bookingsProvider.bookings.isEmpty) {
            return const Center(child: Text('No bookings available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookingsProvider.bookings.length,
            itemBuilder: (context, index) {
              BookingModel booking = bookingsProvider.bookings[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('MMMM d, yyyy - hh:mm a')
                                .format(booking.datetime),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 8),
                          Text(
                            'From: ${booking.origin}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 8),
                          Text(
                            'To: ${booking.destination}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const Divider(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Price:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'LKR ${booking.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Seat Numbers:',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            booking.ticketNumbers,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
