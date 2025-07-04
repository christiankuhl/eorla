import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool _nerdMode = false;
  bool get nerdMode => _nerdMode;

  void toggleNerdMode() {
    _nerdMode = !_nerdMode;
    notifyListeners();
  }
}
