import 'package:flutter/material.dart';
import 'package:ride_mate/Admin_panel/add_driver.dart';
import 'package:ride_mate/Admin_panel/admin_profile.dart';
import 'package:ride_mate/Admin_panel/bookings_summery.dart';
import 'package:ride_mate/Admin_panel/bus_management.dart';
import 'package:ride_mate/Admin_panel/transition_monitor.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 205, 174, 0),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome, Admin!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 205, 174, 0),
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildDashboardCard(
                    context,
                    'Manage Drivers',
                    Icons.person,
                    Colors.orange,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriverManagementPage())),
                  ),
                  _buildDashboardCard(
                    context,
                    'Buses & Routes',
                    Icons.directions_bus,
                    Colors.green,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BusManagementScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    'Bookings',
                    Icons.book_online,
                    Colors.purple,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingsSummeryScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    'Transactions',
                    Icons.payment,
                    Colors.blue,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransitionMonitorScreen())),
                  ),
                  _buildDashboardCard(
                    context,
                    'Profile',
                    Icons.notifications_active,
                    Colors.red,
                    () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminProfileScreen())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
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
