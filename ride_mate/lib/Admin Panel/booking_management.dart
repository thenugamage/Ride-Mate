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
      title: 'Booking Management',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookingManagementPage(),
    );
  }
}

class BookingManagementPage extends StatefulWidget {
  @override
  _BookingManagementPageState createState() => _BookingManagementPageState();
}

class _BookingManagementPageState extends State<BookingManagementPage> {
  List<Map<String, String>> bookings = [
    {
      "passenger": "John Doe",
      "busNumber": "123",
      "seat": "A1",
      "status": "Confirmed",
    },
    {
      "passenger": "Jane Smith",
      "busNumber": "456",
      "seat": "B5",
      "status": "Pending",
    },
    {
      "passenger": "Michael Johnson",
      "busNumber": "789",
      "seat": "C3",
      "status": "Canceled",
    },
  ];

  void _addBooking() {
    TextEditingController passengerController = TextEditingController();
    TextEditingController busNumberController = TextEditingController();
    TextEditingController seatController = TextEditingController();
    TextEditingController statusController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passengerController,
                decoration: InputDecoration(labelText: 'Passenger Name'),
              ),
              TextField(
                controller: busNumberController,
                decoration: InputDecoration(labelText: 'Bus Number'),
              ),
              TextField(
                controller: seatController,
                decoration: InputDecoration(labelText: 'Seat Number'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Booking Status'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (passengerController.text.isEmpty ||
                    busNumberController.text.isEmpty ||
                    seatController.text.isEmpty ||
                    statusController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields')),
                  );
                } else {
                  setState(() {
                    bookings.add({
                      "passenger": passengerController.text.trim(),
                      "busNumber": busNumberController.text.trim(),
                      "seat": seatController.text.trim(),
                      "status": statusController.text.trim(),
                    });
                  });
                  Navigator.of(context).pop();
                  _showBookingAddedConfirmation(
                    passengerController.text,
                    busNumberController.text,
                    seatController.text,
                    statusController.text,
                  );
                }
              },
              child: Text('Add Booking'),
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

  void _showBookingAddedConfirmation(
    String passenger,
    String busNumber,
    String seat,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Added'),
          content: Text(
            'Booking for $passenger on bus $busNumber, seat $seat with status $status has been added.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _deleteBooking(int index) {
    setState(() {
      bookings.removeAt(index);
    });
  }

  void _viewBooking(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Passenger: ${bookings[index]["passenger"]}'),
              Text('Bus Number: ${bookings[index]["busNumber"]}'),
              Text('Seat: ${bookings[index]["seat"]}'),
              Text('Status: ${bookings[index]["status"]}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _editBooking(int index) {
    TextEditingController passengerController = TextEditingController(
      text: bookings[index]["passenger"],
    );
    TextEditingController busNumberController = TextEditingController(
      text: bookings[index]["busNumber"],
    );
    TextEditingController seatController = TextEditingController(
      text: bookings[index]["seat"],
    );
    TextEditingController statusController = TextEditingController(
      text: bookings[index]["status"],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Booking'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passengerController,
                decoration: InputDecoration(labelText: 'Passenger Name'),
              ),
              TextField(
                controller: busNumberController,
                decoration: InputDecoration(labelText: 'Bus Number'),
              ),
              TextField(
                controller: seatController,
                decoration: InputDecoration(labelText: 'Seat Number'),
              ),
              TextField(
                controller: statusController,
                decoration: InputDecoration(labelText: 'Booking Status'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  bookings[index] = {
                    "passenger": passengerController.text.trim(),
                    "busNumber": busNumberController.text.trim(),
                    "seat": seatController.text.trim(),
                    "status": statusController.text.trim(),
                  };
                });
                Navigator.of(context).pop();
                _showBookingUpdatedConfirmation(
                  bookings[index]["passenger"]!,
                  bookings[index]["busNumber"]!,
                  bookings[index]["seat"]!,
                  bookings[index]["status"]!,
                );
              },
              child: Text('Save'),
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

  void _showBookingUpdatedConfirmation(
    String passenger,
    String busNumber,
    String seat,
    String status,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking Updated'),
          content: Text(
            'Booking for $passenger on bus $busNumber, seat $seat with status $status has been updated.',
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
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

          // 👇 Foreground content
          SafeArea(
            child: Column(
              children: [
                // 🧢 Gradient AppBar
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Booking Management',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.black),
                      onPressed: _addBooking,
                      tooltip: 'Add Booking',
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Manage and View All Bookings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(15),
                          leading: Icon(
                            Icons.book_online,
                            color: Colors.yellow,
                            size: 40,
                          ),
                          title: Text(
                            bookings[index]["passenger"]!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "Bus: ${bookings[index]["busNumber"]}\nSeat: ${bookings[index]["seat"]}\nStatus: ${bookings[index]["status"]}",
                            style: TextStyle(fontSize: 14),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: Colors.blue,
                                ),
                                onPressed: () => _viewBooking(index),
                                tooltip: 'View',
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editBooking(index),
                                tooltip: 'Edit',
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deleteBooking(index),
                                tooltip: 'Delete',
                              ),
                            ],
                          ),
                        ),
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