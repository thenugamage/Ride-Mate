import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get userPhone => _userPhone;

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setUserEmail(String email) {
    _userEmail = email;
    notifyListeners();
  }

  void setUserPhone(String phone) {
    _userPhone = phone;
    notifyListeners();
  }
}
