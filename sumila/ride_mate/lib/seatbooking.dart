import 'package:flutter/material.dart';
import 'navigationbar.dart'; // Import the CustomBottomNavigationBar

class SeatBookingPage extends StatelessWidget {
  final String travelCompany;

  const SeatBookingPage({super.key, required this.travelCompany});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                          backgroundImage: AssetImage('assets/Avatar.png'),
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Saduni Silva!",
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
                            "Kelaniya",
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
                            "Colombo",
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
                          "08th - Dec - 2024 | Sunday",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Travel Card inside the Travel Info Card
                      travelCard(
                        context,
                        "Perera Travels",
                        "A/C Sleeper (2+2)",
                        "9:00 AM - 9:45 AM",
                        "15 Seats left",
                        Colors.green,
                        "LKR 200",
                        "45 Min",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Seat Booking Grid with Legend
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 230,
                          height: 230,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  _seatCell(Colors.red), // Booked
                                  _seatCell(Colors.grey), // Available
                                  _seatCell(Colors.purple), // Available
                                  _seatCell(Colors.grey), // Available
                                ],
                              ),
                              Row(
                                children: [
                                  _seatCell(Colors.red), // Booked
                                  _seatCell(Colors.orange), // Your Seat
                                  _seatCell(Colors.purple), // Available
                                  _seatCell(Colors.orange), // Your Seat
                                ],
                              ),
                              Row(
                                children: [
                                  _seatCell(Colors.purple), // Available
                                  _seatCell(Colors.red), // Booked
                                  _seatCell(Colors.orange), // Your Seat
                                  _seatCell(Colors.purple), // Available
                                ],
                              ),
                              Row(
                                children: [
                                  _seatCell(Colors.pink), // Female
                                  _seatCell(Colors.blue), // Male
                                  _seatCell(Colors.orange), // Your Seat
                                  _seatCell(Colors.purple), // Available
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(height: 20, width: 20, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Booked"),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 8),
                            Text("Your Seat"),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: Colors.purple,
                            ),
                            SizedBox(width: 8),
                            Text("Available"),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: Colors.blue,
                            ),
                            SizedBox(width: 8),
                            Text("Male"),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 8),
                            Text("Female"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Add your current index here
        onTap: (index) {
          // Handle the navigation logic if needed here
        },
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
        // Navigate to SeatBookingPage when tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeatBookingPage(travelCompany: title),
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
