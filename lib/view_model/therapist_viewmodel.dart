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
    notifyListeners();

    try {
      _therapists = await _service.fetchAllTherapists();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load therapists';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addTherapist(Therapist therapist) async {
    try {
      await _service.addTherapist(therapist);
      await loadTherapists();
    } catch (e) {
      _errorMessage = 'Failed to add therapist';
      notifyListeners();
    }
  }

  Future<void> updateTherapist(Therapist updatedTherapist) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _service.updateTherapist(updatedTherapist);
      await loadTherapists();
    } catch (e) {
      _errorMessage = 'Failed to update therapist';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> deleteTherapist(String id) async {
    try {
      await _service.deleteTherapist(id);
      await loadTherapists();
    } catch (e) {
      _errorMessage = 'Failed to delete therapist';
      notifyListeners();
    }
  }
}
