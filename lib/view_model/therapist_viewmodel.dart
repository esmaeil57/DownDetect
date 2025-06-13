import 'package:flutter/material.dart';
import '../data/models/therapist_model.dart';
import '../data/services/therapist_service.dart';

class TherapistViewModel extends ChangeNotifier {
  final TherapistService _service = TherapistService();

  List<Therapist> _therapists = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Therapist> get therapists => _therapists;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadTherapists() async {
    _isLoading = true;
    _errorMessage = null; // Clear previous errors
    notifyListeners();

    try {
      print('Loading therapists...'); // Debug log
      _therapists = await _service.fetchAllTherapists();
      print('Loaded ${_therapists.length} therapists'); // Debug log
      _errorMessage = null;
    } catch (e) {
      print('Error loading therapists: $e'); // Debug log
      _errorMessage = 'Failed to load therapists: $e';
      _therapists = []; // Clear list on error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTherapist(Therapist therapist) async {
    try {
      print('Adding therapist: ${therapist.name}'); // Debug log

      // Add therapist to database
      await _service.addTherapist(therapist);
      print('Therapist added to database successfully'); // Debug log

      // Reload the list to get updated data
      await loadTherapists();
      print('Therapist list reloaded'); // Debug log

    } catch (e) {
      print('Error adding therapist: $e'); // Debug log
      _errorMessage = 'Failed to add therapist: $e';
      notifyListeners();
      // Re-throw the error so the UI can handle it
      throw e;
    }
  }

  Future<void> updateTherapist(Therapist updatedTherapist) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      print('Updating therapist: ${updatedTherapist.name}'); // Debug log
      await _service.updateTherapist(updatedTherapist);
      await loadTherapists();
      print('Therapist updated successfully'); // Debug log

    } catch (e) {
      print('Error updating therapist: $e'); // Debug log
      //_errorMessage = 'Failed to update therapist: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteTherapist(String id) async {
    try {
      print('Deleting therapist with id: $id'); // Debug log
      await _service.deleteTherapist(id);
      await loadTherapists();
      print('Therapist deleted successfully'); // Debug log

    } catch (e) {
      print('Error deleting therapist: $e'); // Debug log
      _errorMessage = 'Failed to delete therapist: $e';
      notifyListeners();
    }
  }

  // Method to clear error messages
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Method to manually refresh the list
  Future<void> refresh() async {
    await loadTherapists();
  }
}