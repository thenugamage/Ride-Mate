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
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient (Only in the top part)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),

          /// Grid Pattern (Starts after the logo)
          Positioned(
            top: 328, // Adjust to start grid below the logo
            left: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 1.0,
              child: Image.asset(
                'assets/gridpattern.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Page Content
          SafeArea(
            child: Column(
              children: [
                const Spacer(),

                /// App Logo
                Image.asset(
                  'assets/Logo1.png',
                  height: 250,
                ),

                const Spacer(),

                /// Welcome Text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        "Welcome to the app",
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "An app for convenient bus seat booking, schedules, payments, and travel updates in Sri Lanka.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(91, 42, 42, 1),
                        ),
                      ),
                      SizedBox(height: 30),

                      /// Dots Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, size: 10, color: Colors.black),
                          SizedBox(width: 10),
                          Icon(Icons.circle, size: 10, color: Colors.grey),
                          SizedBox(width: 10),
                          Icon(Icons.circle, size: 10, color: Colors.grey),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                /// Get Started Button
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: 250, // Set desired width
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 130, 119, 23), // Border color
                      width: 2,           // Border width
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),



                const SizedBox(height: 15),

                /// Create Account Link
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Create an account",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 141, 141, 141), // Change to any color you prefer
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                ),


                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
