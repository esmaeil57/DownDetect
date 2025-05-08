import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FontScaleViewModel extends ChangeNotifier {
  double _currentScale = 1.0;

  double get currentScale => _currentScale;

  FontScaleViewModel() {
    _loadFontScale(); // Load when app starts
  }

  void setScale(double newScale) async {
    _currentScale = newScale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontScale', newScale);
  }

  void resetToSystemDefault() async {
    _currentScale = 1.0;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('fontScale');
  }

  void _loadFontScale() async {
    final prefs = await SharedPreferences.getInstance();
    _currentScale = prefs.getDouble('fontScale') ?? 1.0;
    notifyListeners();
  }
}
    