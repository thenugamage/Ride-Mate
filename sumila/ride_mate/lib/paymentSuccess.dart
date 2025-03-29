import 'package:flutter/material.dart';
import 'package:ride_mate/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Paymentsuccess extends StatelessWidget {
  const Paymentsuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),

          /// Grid Pattern
          Positioned(
            top: 300,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //// Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 20),

                /// App Logo
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Image.asset(
                      'assets/Logo1.png',
                      height: 80,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// Success Illustration
                Image.asset(
                  'assets/paymentsuccess.png',
                  height: 240,
                ),

                const SizedBox(height: 0),

                /// Success Text
                Text(
                  "Your order has been placed successfully",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                /// Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Thank you for choosing us! Feel free to continue shopping and explore our wide range of products. Happy Shopping!",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                /// Back to Homepage Button
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 130, 119, 23),
                        width: 2,
                      ),
                    ),
                    child: const Text(
                      "Back To Homepage",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
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
