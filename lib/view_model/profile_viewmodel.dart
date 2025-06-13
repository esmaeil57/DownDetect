import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/user_model.dart';
import '../data/services/user_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final UserService _userService = UserService();

  User? _user;
  User? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  File? _profileImage;
  File? get profileImage => _profileImage;

  String? _cachedProfileImagePath;
  String? get cachedProfileImagePath => _cachedProfileImagePath;

  // Track current user token to detect changes
  String? _currentUserToken;

  ProfileViewModel() {
    initialize();
  }

  // New initialization method that can be called when user changes
  Future<void> initialize() async {
    _currentUserToken = await _userService.getSavedToken();
    await loadUserProfile();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Check if user has changed and reset if needed
  Future<void> checkForUserChange() async {
    final newToken = await _userService.getSavedToken();

    // If token changed, reset everything
    if (newToken != _currentUserToken) {
      // Clear old data
      _user = null;
      _profileImage = null;
      _cachedProfileImagePath = null;
      _currentUserToken = newToken;
      notifyListeners();

      // Load new data
      if (newToken != null) {
        await loadUserProfile();
      }
    }
  }

  Future<void> loadUserProfile() async {
    _setLoading(true);
    try {
      _user = await _userService.fetchProfile();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load profile: ${e.toString()}';
      print(_errorMessage);
    } finally {
      _setLoading(false);
    }
  }

  // Method to fully reset profile data
  Future<void> resetProfile() async {
    _user = null;
    _profileImage = null;
    _cachedProfileImagePath = null;
    _errorMessage = null;
    _currentUserToken = null;
    notifyListeners();
  }

}