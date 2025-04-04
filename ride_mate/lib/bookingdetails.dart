import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/models/bus_model.dart';
import 'package:ride_mate/providers/user_provider.dart';
// Import the CustomBottomNavigationBar
import 'guestdetails.dart'; // Import the GuestDetailsPage

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage(
      {super.key,
      required this.travelCompany,
      required this.origin,
      required this.destination,
      required this.dateTime,
      required this.bus,
      required this.selectedSeats});

  final String travelCompany;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Bus bus;
  final Set<int> selectedSeats;

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.selectedSeats.length * 200;
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
                              context.read<UserProvider>().userName,
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
                          style: TextStyle(color: Colors.white, fontSize: 14),
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
                SizedBox(height: 16),

                // New section under the Travel Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
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
                      // Origin and Destination Display
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Boarding Point:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              widget.origin,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                'Drop Point:',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              widget.destination,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Selected Seats and Total Fare
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seat count: ${widget.selectedSeats.length}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Selected Seats: ${widget.selectedSeats.toList().join(", ")}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Total Fare: LKR $totalPrice',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Proceed Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to GuestDetailsPage when Proceed is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuestDetailsPage(
                                bus: widget.bus,
                                dateTime: widget.dateTime,
                                destination: widget.destination,
                                origin: widget.origin,
                                selectedSeats: widget.selectedSeats,
                                travelCompany: widget.travelCompany,
                                price: totalPrice,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.orange, // Use backgroundColor
                        ),
                        child: Text("Proceed to Book",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Travel Card Widget
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => BookingDetailsPage(),
        //   ),
        // );
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
}
