import 'package:flutter/material.dart';
import 'package:ride_mate/all_bus_details.dart';
import 'package:ride_mate/bookings.dart';
import 'package:ride_mate/home.dart';
import 'package:ride_mate/settings.dart';

class NavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  Widget currentScreen = const HomePage();

  void updateIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      currentScreen = const HomePage();
    } else if (currentIndex == 1) {
      currentScreen = const AllBusDetailsScreen();
    } else if (currentIndex == 2) {
      currentScreen = const BookingsScreen();
    } else {
      currentScreen = const SettingsPage();
    }
    notifyListeners();
  }
}
