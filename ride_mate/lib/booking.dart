import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/models/bus_model.dart';
import 'package:ride_mate/providers/user_provider.dart';
import 'navigationbar.dart';

class BookingPage extends StatelessWidget {
  const BookingPage(
      {super.key,
      required this.currentIndex,
      required this.onTap,
      required this.ticket,
      required this.travelCompany,
      required this.origin,
      required this.destination,
      required this.dateTime,
      required this.bus,
      required this.selectedSeats});
  final int currentIndex;
  final Function(int) onTap;
  final Map<String, dynamic> ticket;
  final String travelCompany;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Bus bus;
  final Set<int> selectedSeats;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
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
          Container(
            decoration: BoxDecoration(
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
              child: Image.asset('assets/gridpattern.png', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
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
                SizedBox(height: 16),
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
                      Image.asset('assets/Logo1.png', height: 91),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ticket['from'],
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
                            ticket['to'],
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
                          ticket['date'],
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children: [
                      travelCard(
                        context,
                        "Perera Travels",
                        "A/C Sleeper (2+2)",
                        "${ticket['time']} - 9:45 AM",
                        "15 Seats left",
                        Colors.green,
                        "LKR 200",
                        "45 Min",
                      ),
                      travelCard(
                        context,
                        "Gayan Express",
                        "A/C Sleeper (2+2)",
                        "${ticket['time']} - 9:20 AM",
                        "2 Seats left",
                        Colors.red,
                        "LKR 250",
                        "20 Min",
                      ),
                      travelCard(
                        context,
                        "Shehan Travels",
                        "Non A/C Sleeper (2+1)",
                        "${ticket['time']} - 9:45 AM",
                        "5 Seats left",
                        Colors.green,
                        "LKR 100",
                        "45 Min",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
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
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => SeatBookingPage(travelCompany: title),
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
