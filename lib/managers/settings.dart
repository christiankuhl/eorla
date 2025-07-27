import 'package:flutter/material.dart';

class AppSettings extends ChangeNotifier {
  bool _nerdMode = false;
  bool _useAnimations = true;
  bool _useCritTable = false;
  bool _useBotchTable = false;
  bool _useFocusRulesCrit = false;
  bool _useFocusRulesBotch = false;
  bool get nerdMode => _nerdMode;
  bool get useAnimations => _useAnimations;
  bool get useCritTable => _useCritTable;
  bool get useBotchTable => _useBotchTable;
  bool get useFocusRulesCrit => _useCritTable && _useFocusRulesCrit;
  bool get useFocusRulesBotch => _useBotchTable && _useFocusRulesBotch;

  void toggleNerdMode() {
    _nerdMode = !_nerdMode;
    notifyListeners();
  }

  void toggleAnimations() {
    _useAnimations = !_useAnimations;
    notifyListeners();
  }

  void toggleCritTable() {
    _useCritTable = !_useCritTable;
    notifyListeners();
  }

  void toggleBotchTable() {
    _useBotchTable = !_useBotchTable;
    notifyListeners();
  }

  void toggleFocusRulesCrit() {
    _useFocusRulesCrit = !_useFocusRulesCrit;
    notifyListeners();
  }

  void toggleFocusRulesBotch() {
    _useFocusRulesBotch = !_useFocusRulesBotch;
    notifyListeners();
  }
}
