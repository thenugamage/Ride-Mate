import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    // Simulate loading user data (replace with actual user data fetching logic)
    _nameController.text = "John Doe";
    _emailController.text = "johndoe@example.com";
  }

  void _saveProfile() {
    // Logic to save profile changes (e.g., update Firebase or local storage)
    final name = _nameController.text;
    final email = _emailController.text;

    // Example: Print the updated values
    print("Updated Name: $name");
    print("Updated Email: $email");

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            top: 250, // Adjusted to match the design
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Back Button and Edit Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(width: 40),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  /// Profile Title
                  Text(
                    "My Profile",
                    style: GoogleFonts.carterOne(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  /// Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: Image.asset('assets/ben10.jpeg'),
                  ),

                  const SizedBox(height: 30),

                  /// Input Fields
                  _buildInputField("First Name", "Yuhas"),
                  const SizedBox(height: 15),
                  _buildInputField("Last Name", "Himsanda"),
                  const SizedBox(height: 15),
                  _buildInputField("Email Address", "2004yuhashimsanda@gmail.com"),
                  const SizedBox(height: 15),
                  _buildInputField("Age", "21"),

                  const SizedBox(height: 20),

                  /// Gender Selection
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Gender",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      _buildRadioOption("Male", true),
                      _buildRadioOption("Female", false),
                      _buildRadioOption("Other", false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the input fields
  Widget _buildInputField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          readOnly: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            hintText: value,
            hintStyle: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  /// Builds the gender selection radio buttons
  Widget _buildRadioOption(String text, bool isSelected) {
    return Row(
      children: [
        Radio(
          value: text,
          groupValue: isSelected ? text : null,
          onChanged: (value) {},
          activeColor: Colors.blue,
        ),
        Text(
          text,
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ],
    );
  }
}
