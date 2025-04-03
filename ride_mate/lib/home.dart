import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'navigationbar.dart';
import 'settings.dart';
import 'booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;
  String userName = "User";
  String? userPhoto;

  final TextEditingController _boardingController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _selectedDateLabel = "Today";
  String _selectedTime = "9:00 AM";
  final List<String> _availableTimes = [
    "6:00 AM",
    "9:00 AM",
    "12:00 PM",
    "3:00 PM",
    "6:00 PM",
    "9:00 PM"
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  void _fetchUserInfo() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName ?? "User";
        userPhoto = user.photoURL;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget nextScreen;
    switch (index) {
      case 0:
        nextScreen = const HomePage();
        break;
      case 1:
        nextScreen = const HomePage();
        break;
      case 2:
        nextScreen = const HomePage();
        break;
      case 3:
        nextScreen = const SettingsPage();
        break;
      default:
        nextScreen = const HomePage();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedDateLabel =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _navigateToBookingPage(int index) {
    final ticket = {
      'terminal': "Bus terminal ${index + 1}",
      'from': _boardingController.text.isNotEmpty
          ? _boardingController.text
          : (index == 1 ? "Biyagama" : "Kelaniya"),
      'to': _destinationController.text.isNotEmpty
          ? _destinationController.text
          : (index == 1 ? "Kelaniya" : "Colombo"),
      'date': _selectedDateLabel,
      'time': _selectedTime,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingPage(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          ticket: ticket,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Stack(
        children: [
          /// Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),

          /// Grid overlay (faint pattern)
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/gridpattern.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Main content (scrollable)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Profile Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: userPhoto != null
                              ? NetworkImage(userPhoto!)
                              : const AssetImage("assets/Avatar.png")
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, $userName!",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Where you want to go?",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Image.asset('assets/Logo1.png', height: 80),
                      ],
                    ),
                  ),

                  /// Bus Search Section
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _boardingController,
                                decoration: const InputDecoration(
                                  labelText: 'Boarding From',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _destinationController,
                                decoration: const InputDecoration(
                                  labelText: 'Where are you going?',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime.now();
                                  _selectedDateLabel = "Today";
                                });
                              },
                              child: const Text('Today'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedDate = DateTime.now()
                                      .add(const Duration(days: 1));
                                  _selectedDateLabel = "Tomorrow";
                                });
                              },
                              child: const Text('Tomorrow'),
                            ),
                            ElevatedButton(
                              onPressed: _pickDate,
                              child: const Text('Other'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Departure Time",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedTime,
                              isExpanded: true,
                              items: _availableTimes.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  if (newValue != null) {
                                    _selectedTime = newValue;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Find Buses'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      /// Bottom Nav
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
