import 'package:flutter/material.dart';
import 'package:ride_mate/seatbooking.dart';
import 'package:ride_mate/widgets/bus_card.dart';
import 'package:ride_mate/data/bus_data.dart';
import 'package:intl/intl.dart';

class AllBusDetailsScreen extends StatefulWidget {
  const AllBusDetailsScreen({super.key});

  @override
  State<AllBusDetailsScreen> createState() => _AllBusDetailsScreenState();
}

class _AllBusDetailsScreenState extends State<AllBusDetailsScreen> {
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
                    'Available Buses',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: sampleBusData.length,
                      itemBuilder: (context, index) {
                        final bus = sampleBusData[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => SeatBookingPage(
                                  travelCompany: "Test",
                                  origin: bus.origin,
                                  destination: bus.destination,
                                  dateTime: bus.date,
                                  bus: bus,
                                ),
                              ),
                            );
                            print('Tapped on bus ID: ${bus.id}');
                          },
                          child: BusCard(
                            index: bus.id,
                            boardingLocation: bus.origin,
                            destination: bus.destination,
                            departureTime:
                                DateFormat('hh:mm a').format(bus.departureTime),
                            departureDate:
                                DateFormat('yyyy-MM-dd').format(bus.date),
                          ),
                        );
                      },
                    ),
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
