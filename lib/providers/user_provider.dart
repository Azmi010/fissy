import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? loggedInUsername;

  void setLoggedInUsername(String username) {
    loggedInUsername = username;
    notifyListeners();
  }
}