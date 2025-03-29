import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

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
                const SizedBox(height: 10),

                /// Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                /// Verification Title
                Text(
                  "Verification",
                  style: GoogleFonts.carterOne(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                /// App Logo
                Image.asset(
                  'assets/Logo1.png',
                  height: 250,
                ),

                const SizedBox(height: 10),

                /// Instructions
                Text(
                  "Enter the verification code",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  child: Text(
                    "We've sent a 4-digit verification code to your email. Please enter the OTP code below to continue.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// OTP Input Fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    defaultPinTheme: PinTheme(
                      height: 88,
                      width: 66,
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color.fromARGB(255, 130, 119, 23)),
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(0, 255, 255, 255),
                      ),
                    ),
                    showCursor: true,
                  ),
                ),

                const SizedBox(height: 20),

                /// Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () {},
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
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                /// Resend Button
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),

                const Spacer(),

                /// Terms & Privacy Policy
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "the terms of service and privacy policy.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black54,
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
