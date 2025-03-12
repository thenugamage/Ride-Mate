import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String userName = "User";
  String? userPhoto;
  bool isDarkMode = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 251, 222),
      body: Stack(
        children: [
          /// Background Gradient & Pattern
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color.fromARGB(255, 205, 174, 0)],
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/gridpattern.png',
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        },
                      ),
                      const SizedBox(width: 80),
                      const Icon(Icons.settings, size: 28, color: Colors.black),
                      const SizedBox(width: 8),
                      Center(
                        child: const Text(
                          "Settings",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Profile Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 1),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundImage: userPhoto != null
                              ? NetworkImage(userPhoto!)
                              : const AssetImage("assets/default_profile.png")
                                  as ImageProvider,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          userName,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Settings Options
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _settingsCategory("Account Settings"),
                        _settingsOption("Edit profile", Icons.arrow_forward_ios),
                        _settingsOption("Change password", Icons.arrow_forward_ios),
                        _settingsOption("Add a payment method", Icons.add),
                        _settingsOption("Offers"),
                        _settingsOption("Booking"),

                        /// Dark Mode Toggle
                        _darkModeToggle(),

                        const SizedBox(height: 10),

                        _settingsCategory("More"),
                        _settingsOption("Rate and earn"),
                        _settingsOption("About us", Icons.arrow_forward_ios),
                        _settingsOption("Privacy policy", Icons.arrow_forward_ios),
                        _settingsOption("Terms and conditions", Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }

  /// Category Title Widget
  Widget _settingsCategory(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Settings Option Item
  Widget _settingsOption(String title, [IconData? icon]) {
    return ListTile(
      title: Text(title),
      trailing: icon != null ? Icon(icon, size: 18, color: Colors.black) : null,
      onTap: () {},
    );
  }

  /// Dark Mode Toggle Switch
  Widget _darkModeToggle() {
    return ListTile(
      title: const Text("Dark mode"),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          setState(() {
            isDarkMode = value;
          });
        },
      ),
    );
  }
}
