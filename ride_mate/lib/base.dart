import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ride_mate/providers/navigation_provider.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: context.watch<NavigationProvider>().currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<NavigationProvider>().currentIndex,
        selectedItemColor: Colors.black, // Selected item color
        unselectedItemColor: Colors.grey, // Unselected item color
        backgroundColor: Colors.white, // Background color
        onTap: (value) {
          context.read<NavigationProvider>().updateIndex(value);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus), label: "Tickets"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: "Bookings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}
