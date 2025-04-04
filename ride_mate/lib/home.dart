import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/all_bus_details.dart';
import 'package:ride_mate/models/bus_model.dart';
import 'package:ride_mate/providers/user_provider.dart';
import 'package:ride_mate/seatbooking.dart';
import 'package:ride_mate/widgets/bus_card.dart';
import 'package:ride_mate/data/bus_data.dart';
import 'settings.dart';

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

  List<Bus>? filteredBuses; // Changed to nullable type
  bool hasSearched = false; // Added search tracking

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
      context.read<UserProvider>().setUserName(userName);
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
        nextScreen = const AllBusDetailsScreen();
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

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => BookingPage(
    //       currentIndex: _selectedIndex,
    //       onTap: _onItemTapped,
    //       ticket: ticket,
    //     ),
    //   ),
    // );
  }

  bool _validateInputs() {
    // Remove validation requirements to allow partial searches
    return true; // Always return true to allow searching with partial inputs
  }

  void _searchBuses() {
    setState(() {
      hasSearched = true;
      filteredBuses = sampleBusData.where((bus) {
        bool matchesOrigin = true;
        bool matchesDestination = true;

        // Only check origin if user entered something
        if (_boardingController.text.isNotEmpty) {
          matchesOrigin = bus.origin
              .toLowerCase()
              .contains(_boardingController.text.toLowerCase());
        }

        // Only check destination if user entered something
        if (_destinationController.text.isNotEmpty) {
          matchesDestination = bus.destination
              .toLowerCase()
              .contains(_destinationController.text.toLowerCase());
        }

        return matchesOrigin && matchesDestination;
      }).toList();
    });
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
                  /// Top Navigation and Profile

                  /// Profile Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                                "https://randomuser.me/api/portraits/men/32.jpg")),
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
                        const Text(
                          "Pickup & Destination",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
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
                        const Text(
                          "Departure Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        InkWell(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(_selectedDateLabel),
                                const Icon(Icons.calendar_today),
                              ],
                            ),
                          ),
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
                          onPressed: _searchBuses,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Find Buses'),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          "Available Buses",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (!hasSearched)
                          Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const Icon(
                                  Icons.search,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Search for available buses',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else if (filteredBuses!.isEmpty)
                          Center(
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                const Icon(
                                  Icons.directions_bus_outlined,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No buses found for your search criteria',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Try different date, time or location',
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Column(
                            children: filteredBuses!.map((bus) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => SeatBookingPage(
                                        travelCompany: "Kasun Travels",
                                        origin: bus.origin,
                                        destination: bus.destination,
                                        dateTime: bus.date,
                                        bus: bus,
                                      ),
                                    ),
                                  );
                                  print('Tapped on bus ID: ${bus.id}');
                                },
                                child: BusCard(
                                  index: bus.id,
                                  boardingLocation: bus.origin,
                                  destination: bus.destination,
                                  departureTime:
                                      '${bus.departureTime.hour}:${bus.departureTime.minute.toString().padLeft(2, '0')}',
                                  departureDate:
                                      '${bus.date.year}-${bus.date.month}-${bus.date.day}',
                                ),
                              );
                            }).toList(),
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
    );
  }
}
