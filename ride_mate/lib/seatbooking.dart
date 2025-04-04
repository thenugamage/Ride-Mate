import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/models/bus_model.dart';
import 'package:ride_mate/providers/user_provider.dart';
import 'bookingdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_mate/models/seat_booking.dart';

// Convert to StatefulWidget
class SeatBookingPage extends StatefulWidget {
  const SeatBookingPage(
      {super.key,
      required this.travelCompany,
      required this.origin,
      required this.destination,
      required this.dateTime,
      required this.bus});

  final String travelCompany;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Bus bus;

  @override
  State<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends State<SeatBookingPage> {
  // Selected seat tracking
  Set<int> selectedSeats = {};
  Set<int> bookedSeats = {};

  @override
  void initState() {
    super.initState();
    _loadBookedSeats();
  }

  Future<void> _loadBookedSeats() async {
    final dateStr = DateFormat('yyyy-MM-dd').format(widget.dateTime);
    final bookingDoc = await FirebaseFirestore.instance
        .collection('seatBookings')
        .doc('${widget.bus.id}_$dateStr')
        .get();

    if (bookingDoc.exists) {
      final booking = SeatBooking.fromJson(bookingDoc.data()!);
      setState(() {
        bookedSeats = Set.from(booking.bookedSeats);
      });
    }
  }

  Future<void> _saveBookedSeats() async {
    final dateStr = DateFormat('yyyy-MM-dd').format(widget.dateTime);
    final booking = SeatBooking(
      busId: widget.bus.id,
      travelDate: dateStr,
      bookedSeats: [...bookedSeats, ...selectedSeats],
    );

    await FirebaseFirestore.instance
        .collection('seatBookings')
        .doc('${widget.bus.id}_$dateStr')
        .set(booking.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(
              context,
            ); // Go back to the previous page (BookingPage)
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),
          // Grid Pattern as Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/gridpattern.png', fit: BoxFit.cover),
            ),
          ),
          // Main Content
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Ride Mate Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Avatar and User Info
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                    "https://randomuser.me/api/portraits/men/32.jpg")),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello ${context.read<UserProvider>().userName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Where you want go",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Ride Mate Logo aligned with the Avatar
                        Row(
                          children: [
                            Image.asset(
                              'assets/Logo1.png', // Path to your 'Ride Mate' logo image
                              height: 70, // Adjust the size as needed
                              width: 100, // Adjust the size as needed
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // Travel Info Card
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFD4C98F), Color(0xFFA89F69)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Travel Info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.origin,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Icon(
                                  Icons.swap_horiz,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                widget.destination,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Text(
                              "${DateFormat('yyyy-MM-dd').format(widget.dateTime)} | ${DateFormat('EEEE').format(widget.dateTime)} | ${DateFormat('hh:mm a').format(widget.dateTime)}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 16),

                          // Travel Card inside the Travel Info Card
                          travelCard(
                            context,
                            "Perera Travels",
                            "A/C Sleeper (2+2)",
                            DateFormat('hh:mm a').format(widget.dateTime),
                            "15 Seats left",
                            Colors.green,
                            "LKR 200",
                            "45 Min",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Seat Selection Section
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        // Seat Legend
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildLegendItem(Colors.grey, "Available"),
                              _buildLegendItem(Colors.green, "Selected"),
                              _buildLegendItem(Colors.red, "Booked"),
                            ],
                          ),
                        ),

                        // Seat Grid
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: List.generate(10, (row) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(2, (col) {
                                    final seatNumber = row * 4 + col + 1;
                                    return _buildSeat(seatNumber);
                                  }),
                                  SizedBox(width: 48), // Aisle
                                  ...List.generate(2, (col) {
                                    final seatNumber = row * 4 + col + 3;
                                    return _buildSeat(seatNumber);
                                  }),
                                ],
                              );
                            }),
                          ),
                        ),

                        // Continue Button
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                            onPressed: selectedSeats.isNotEmpty
                                ? () async {
                                    await _saveBookedSeats();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BookingDetailsPage(
                                          bus: widget.bus,
                                          dateTime: widget.dateTime,
                                          destination: widget.destination,
                                          origin: widget.origin,
                                          travelCompany: widget.travelCompany,
                                          selectedSeats: selectedSeats,
                                        ),
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              "Continue (${selectedSeats.length} seats)",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget travelCard(
    BuildContext context,
    String title,
    String type,
    String time,
    String seats,
    Color seatColor,
    String price,
    String duration,
  ) {
    return GestureDetector(
      onTap: () {
        // Navigate to BookingDetailsPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingDetailsPage(
              bus: widget.bus,
              dateTime: widget.dateTime,
              destination: widget.destination,
              origin: widget.origin,
              travelCompany: widget.travelCompany,
              selectedSeats: selectedSeats,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [Colors.white, Color.fromARGB(255, 255, 239, 186)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: Colors.orange,
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(type, style: TextStyle(color: Colors.grey)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(time, style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(duration, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.event_seat, size: 16, color: seatColor),
                      SizedBox(width: 4),
                      Text(seats, style: TextStyle(color: seatColor)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildSeat(int seatNumber) {
    final bool isSelected = selectedSeats.contains(seatNumber);
    final bool isBooked = bookedSeats.contains(seatNumber);

    return GestureDetector(
      onTap: isBooked
          ? null
          : () {
              setState(() {
                if (isSelected) {
                  selectedSeats.remove(seatNumber);
                } else {
                  selectedSeats.add(seatNumber);
                }
              });
            },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isBooked
              ? Colors.red
              : isSelected
                  ? Colors.green
                  : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatNumber.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to generate seat cells
  Widget _seatCell(Color color) {
    return Container(
      margin: EdgeInsets.all(4),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
