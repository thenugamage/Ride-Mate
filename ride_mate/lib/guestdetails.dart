import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/base.dart';
import 'package:ride_mate/models/booking_model.dart';
import 'package:ride_mate/models/bus_model.dart';
import 'package:ride_mate/providers/booking_provider.dart';
import 'package:ride_mate/providers/user_provider.dart';
import 'package:ride_mate/services/stripe_services.dart';
import 'navigationbar.dart'; // Importing the custom navigation bar
import 'payment.dart'; // Importing the PaymentPage

class GuestDetailsPage extends StatefulWidget {
  const GuestDetailsPage({
    super.key,
    required this.travelCompany,
    required this.origin,
    required this.destination,
    required this.dateTime,
    required this.bus,
    required this.selectedSeats,
    required this.price,
  });

  final String travelCompany;
  final String origin;
  final String destination;
  final DateTime dateTime;
  final Bus bus;
  final Set<int> selectedSeats;
  final int price;

  @override
  State<GuestDetailsPage> createState() => _GuestDetailsPageState();
}

class _GuestDetailsPageState extends State<GuestDetailsPage> {
  int? _selectedGender1 = 1; // Default to Male for Passenger 1
  final int? _selectedGender2 = 1; // Default to Male for Passenger 2

  // Add controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isSending = false;

  // Validation method
  bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      _showError('Please enter passenger name');
      return false;
    }
    if (_ageController.text.isEmpty) {
      _showError('Please enter passenger age');
      return false;
    }
    if (_mobileController.text.isEmpty) {
      _showError('Please enter mobile number');
      return false;
    }
    if (_emailController.text.isEmpty) {
      _showError('Please enter email address');
      return false;
    }
    // Email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(_emailController.text)) {
      _showError('Please enter a valid email address');
      return false;
    }
    // Mobile validation (assuming 10 digits)
    if (!RegExp(r'^\d{10}$').hasMatch(_mobileController.text)) {
      _showError('Please enter a valid 10-digit mobile number');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> sendEmail() async {
    setState(() {
      _isSending = true;
    });

    final serviceId = 'service_ou0qtd8';
    final templateId = 'template_clihj0c';
    final userId = 'M4Yu0OH0XvpV93rRZ';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final reqBody = json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_email': _emailController.text,
          'uname': _nameController.text,
          'booking_id': '12345',
          'message': "Seat booking successful.",
        },
      });

      print('Request Payload: $reqBody');

      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: reqBody,
      );

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Email Sent Successfully!'),
              backgroundColor: Colors.green,
            ),
          );

          _nameController.clear();
          _emailController.clear();
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to Send Email: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      print('Exception during API call: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                              "${DateFormat('yyyy-MM-dd').format(widget.dateTime)} | ${DateFormat('EEEE').format(widget.dateTime)} | ${DateFormat('hh:mm a').format(widget.dateTime)}",
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
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Age with Male/Female radio buttons in the same line
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextField(
                                controller: _ageController,
                                decoration: InputDecoration(
                                  labelText: 'Age',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
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
                        SizedBox(height: 20)
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
                          controller: _mobileController,
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 10),

                        // Email Field
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Proceed Button
                  ElevatedButton(
                    onPressed: () async {
                      if (_validateInputs()) {
                        context.read<BookingsProvider>().toggleLoading();
                        await StripeService.instance.makePayment(
                          "Hello",
                        );
                        BookingModel booking = BookingModel(
                          origin: widget.origin,
                          destination: widget.destination,
                          datetime: widget.dateTime,
                          price: widget.price.toDouble(),
                          ticketNumbers: widget.selectedSeats.length.toString(),
                        );

                        context.read<BookingsProvider>().addBooking(booking);

                        await sendEmail();

                        context.read<BookingsProvider>().toggleLoading();

                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Base()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.orange, // Button background color
                    ),
                    child: context.watch<BookingsProvider>().isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : Text('Proceed to Book',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white, // Button text color
                            )),
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
