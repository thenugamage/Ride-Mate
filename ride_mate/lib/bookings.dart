import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/providers/booking_provider.dart';
import 'package:intl/intl.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/gridpattern.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Your Bookings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<BookingsProvider>(
                    builder: (context, bookingsProvider, child) {
                      if (bookingsProvider.bookings.isEmpty) {
                        return const Center(
                          child: Text('No bookings found'),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: bookingsProvider.bookings.length,
                        itemBuilder: (context, index) {
                          final booking = bookingsProvider.bookings[index];
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
