import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool _nerdMode = false;
  bool _useAnimations = true;
  bool get nerdMode => _nerdMode;
  bool get useAnimations => _useAnimations;

  void toggleNerdMode() {
    _nerdMode = !_nerdMode;
    notifyListeners();
  }

  void toggleAnimations() {
    _useAnimations = !_useAnimations;
    notifyListeners();
  }
}
