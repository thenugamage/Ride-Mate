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
  // List of buses with seat grids for each bus
  List<Map<String, dynamic>> buses = [
    {
      "busNumber": "Bus 101",
      "seats": List.generate(8, (row) {
        return List.generate(5, (col) {
          return {
            "status": "Available", // Initially all seats are available
          };
        });
      }),
    },
    {
      "busNumber": "Bus 102",
      "seats": List.generate(8, (row) {
        return List.generate(5, (col) {
          return {
            "status": "Available", // Initially all seats are available
          };
        });
      }),
    },
    {
      "busNumber": "Bus 103",
      "seats": List.generate(8, (row) {
        return List.generate(5, (col) {
          return {
            "status": "Available", // Initially all seats are available
          };
        });
      }),
    },
  ];

  // Track the currently selected bus
  int selectedBusIndex = 0;

  // Function to render each seat
  Widget _buildSeat(int row, int col) {
    String seatStatus = buses[selectedBusIndex]["seats"][row][col]["status"]!;
    Color seatColor;

    // Assigning colors based on seat status
    if (seatStatus == 'Booked') {
      seatColor = Colors.red; // Red for booked seats
    } else if (seatStatus == 'Your Seat') {
      seatColor = Colors.orange; // Orange for selected seat
    } else {
      seatColor = Colors.grey; // Grey for available seats
    }

    return GestureDetector(
      onTap: () {
        if (seatStatus == "Available") {
          _bookSeat(row, col);
        }
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
            '${String.fromCharCode(65 + col)}$row', // A1, B1, C1... etc
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Function to handle seat booking
  void _bookSeat(int row, int col) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Seat Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Seat: ${String.fromCharCode(65 + col)}$row')],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  buses[selectedBusIndex]["seats"][row][col]["status"] =
                      "Your Seat"; // Mark as your seat
                });
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Confirm'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to reset seat status for the selected bus
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
      appBar: AppBar(
        title: Text('Seat Availability', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.yellow,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.black),
            onPressed: _resetSeats,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown to select bus
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

            SizedBox(height: 20),

            // Seat Status Labels
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
            SizedBox(height: 20),

            // Seat Map Grid (8x5)
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5 columns for 40 seats
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 40, // 8 rows x 5 columns = 40 seats
                itemBuilder: (context, index) {
                  int row = index ~/ 5; // Row index
                  int col = index % 5; // Column index
                  return _buildSeat(row, col);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
