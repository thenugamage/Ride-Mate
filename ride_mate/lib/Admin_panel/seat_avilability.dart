import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Advanced Seat Availability',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SeatAvailabilityPage(),
    );
  }
}

class SeatAvailabilityPage extends StatefulWidget {
  @override
  _SeatAvailabilityPageState createState() => _SeatAvailabilityPageState();
}

class _SeatAvailabilityPageState extends State<SeatAvailabilityPage> {
  List<Map<String, dynamic>> buses = [
    {
      "busNumber": "Bus 101",
      "seats": List.generate(
        8,
        (row) => List.generate(5, (col) => {"status": "Available"}),
      ),
    },
    {
      "busNumber": "Bus 102",
      "seats": List.generate(
        8,
        (row) => List.generate(5, (col) => {"status": "Available"}),
      ),
    },
    {
      "busNumber": "Bus 103",
      "seats": List.generate(
        8,
        (row) => List.generate(5, (col) => {"status": "Available"}),
      ),
    },
  ];

  int selectedBusIndex = 0;

  Widget _buildSeat(int row, int col) {
    String seatStatus = buses[selectedBusIndex]["seats"][row][col]["status"]!;
    Color seatColor;

    if (seatStatus == 'Booked') {
      seatColor = Colors.red;
    } else if (seatStatus == 'Your Seat') {
      seatColor = Colors.orange;
    } else {
      seatColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        if (seatStatus == "Available") _bookSeat(row, col);
      },
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: seatColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            '${String.fromCharCode(65 + col)}$row',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _bookSeat(int row, int col) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Seat Booking'),
          content: Text('Seat: ${String.fromCharCode(65 + col)}$row'),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  buses[selectedBusIndex]["seats"][row][col]["status"] =
                      "Your Seat";
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _resetSeats() {
    setState(() {
      for (var row in buses[selectedBusIndex]["seats"]) {
        for (var seat in row) {
          if (seat["status"] == "Your Seat") {
            seat["status"] = "Available";
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌈 Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // 🧢 Gradient AppBar
                AppBar(
                  title: Text(
                    'Seat Availability',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.refresh, color: Colors.black),
                      onPressed: _resetSeats,
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color.fromARGB(255, 205, 174, 0),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DropdownButton<int>(
                        value: selectedBusIndex,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedBusIndex = newValue!;
                          });
                        },
                        items: List.generate(buses.length, (index) {
                          return DropdownMenuItem<int>(
                            value: index,
                            child: Text(buses[index]["busNumber"]),
                          );
                        }),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Booked',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Your Seat',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Available',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 🪑 Seat grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 40,
                      itemBuilder: (context, index) {
                        int row = index ~/ 5;
                        int col = index % 5;
                        return _buildSeat(row, col);
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
