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
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
          Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: AppBar(
                  title: const Text('Admin Dashboard'),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
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
              ),

              // 🧍 Body
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text(
                            'Welcome, Admin!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(text: 'Manage Drivers'),
                          CustomButton(text: 'Manage Buses & Routes'),
                          CustomButton(text: 'Manage Bookings'),
                          CustomButton(text: 'Monitor Transactions'),
                          CustomButton(text: 'Manage Notifications'),
                          CustomButton(text: 'Monitor Seat Availability'),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Exit'),
                          ),
                        ],
                      ),
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
}

// 👇 Custom Reusable Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
        ),
        onPressed: () {
          // Handle your navigation here
        },
        child: Text(text),
      ),
    );
  }
}
