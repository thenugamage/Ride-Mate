import 'package:flutter/material.dart';
import 'package:ride_mate/models/booking_model.dart';

class BookingsProvider extends ChangeNotifier {
  List<BookingModel> _bookings = [];
  List<BookingModel> get bookings => _bookings;
  bool isLoading = false;

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void removeBooking(BookingModel booking) {
    _bookings.remove(booking);
    notifyListeners();
  }

  void clearBookings() {
    _bookings.clear();
    notifyListeners();
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  void loadSampleData() {
    _bookings = [
      BookingModel(
        datetime: DateTime.now(),
        origin: "Colombo",
        destination: "Kandy",
        price: 2500.00,
        ticketNumbers: "A1, A2",
      ),
      BookingModel(
        datetime: DateTime.now().add(const Duration(days: 1)),
        origin: "Galle",
        destination: "Matara",
        price: 1500.00,
        ticketNumbers: "B3, B4",
      ),
      BookingModel(
        datetime: DateTime.now().add(const Duration(days: 2)),
        origin: "Negombo",
        destination: "Colombo",
        price: 1000.00,
        ticketNumbers: "C1",
      ),
    ];
    notifyListeners();
  }
}
