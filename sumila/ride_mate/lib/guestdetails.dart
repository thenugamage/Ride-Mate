import 'package:flutter/material.dart';
import 'navigationbar.dart'; // Importing the custom navigation bar
import 'payment.dart'; // Importing the PaymentPage

class GuestDetailsPage extends StatefulWidget {
  const GuestDetailsPage({super.key});

  @override
  State<GuestDetailsPage> createState() => _GuestDetailsPageState();
}

class _GuestDetailsPageState extends State<GuestDetailsPage> {
  int? _selectedGender1 = 1; // Default to Male for Passenger 1
  int? _selectedGender2 = 1; // Default to Male for Passenger 2

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Removed unnecessary elevation
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
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
          // Main Content wrapped in SingleChildScrollView
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Ride Mate Logo and User Info Section
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

                  // Travel Card Section
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16), // Adjusted padding for smaller size
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Travel Info (Left Aligned)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Perera Travels",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "A/C Sleeper (2+2)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "9:00 AM - 9:45 AM",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        // Logo1.png positioned on the right side
                        Image.asset(
                          'assets/Logo1.png', // Path to your 'Ride Mate' logo image
                          height: 50, // Logo size
                          width: 80, // Logo width
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // Traveller Information Box
                  Container(
                    padding:
                        EdgeInsets.all(12), // Reduced padding for smaller box
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Left-align text
                      children: [
                        Text(
                          "Traveller Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Passenger 1 Information
                        Text("Passenger 1"),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Age with Male/Female radio buttons in the same line
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: _selectedGender1,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender1 = value;
                                    });
                                  },
                                ),
                                Text('Male'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: _selectedGender1,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender1 = value;
                                    });
                                  },
                                ),
                                Text('Female'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Passenger 2 Information
                        Text("Passenger 2"),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Age with Male/Female radio buttons in the same line
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              children: [
                                Radio<int>(
                                  value: 1,
                                  groupValue: _selectedGender2,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender2 = value;
                                    });
                                  },
                                ),
                                Text('Male'),
                              ],
                            ),
                            Row(
                              children: [
                                Radio<int>(
                                  value: 2,
                                  groupValue: _selectedGender2,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender2 = value;
                                    });
                                  },
                                ),
                                Text('Female'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Contact Information Section
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Contact Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 20),

                        // Mobile Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),

                        // Email Field
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Proceed Button
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to PaymentPage when pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.orange, // Button background color
                    ),
                    child: Text('Proceed to Book'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Add your current index here
        onTap: (index) {
          // Handle navigation logic if needed here
        },
      ),
    );
  }
}
