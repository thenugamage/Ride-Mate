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
      title: 'Admin Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AdminDashboard(), // Directly start with Admin Dashboard
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Driver Management
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DriverManagementPage(),
                  ),
                );
              },
              child: Text('Manage Drivers'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Bus & Route Management
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BusRouteManagementPage(),
                  ),
                );
              },
              child: Text('Manage Buses & Routes'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Booking Management
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingManagementPage(),
                  ),
                );
              },
              child: Text('Manage Bookings'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Transaction Monitoring
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionMonitoringPage(),
                  ),
                );
              },
              child: Text('Monitor Transactions'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Notifications Management
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsManagementPage(),
                  ),
                );
              },
              child: Text('Manage Notifications'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to Seat Availability Monitoring
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatAvailabilityPage(),
                  ),
                );
              },
              child: Text('Monitor Seat Availability'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Exit the app
                Navigator.pop(context);
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy Pages for Each Feature
class DriverManagementPage extends StatelessWidget {
  const DriverManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Management'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(child: Text('Driver Management page content goes here.')),
    );
  }
}

class BusRouteManagementPage extends StatelessWidget {
  const BusRouteManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus & Route Management'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Text('Bus & Route Management page content goes here.'),
      ),
    );
  }
}

class BookingManagementPage extends StatelessWidget {
  const BookingManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Management'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(child: Text('Booking Management page content goes here.')),
    );
  }
}

class TransactionMonitoringPage extends StatelessWidget {
  const TransactionMonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Monitoring'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Text('Transaction Monitoring page content goes here.'),
      ),
    );
  }
}

class NotificationsManagementPage extends StatelessWidget {
  const NotificationsManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications Management'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Text('Notifications Management page content goes here.'),
      ),
    );
  }
}

class SeatAvailabilityPage extends StatelessWidget {
  const SeatAvailabilityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seat Availability Monitoring'),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Text('Seat Availability Monitoring page content goes here.'),
      ),
    );
  }
}