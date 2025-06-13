import 'package:flutter/material.dart';
import '../data/models/helpful_video_model.dart';
import '../data/services/helpful_video_service.dart';

class HelpfulVideoViewModel extends ChangeNotifier {
  final HelpfulVideoService _service = HelpfulVideoService();

  List<HelpfulVideo> _videos = [];
  bool _isLoading = false;
  bool _isAddingVideo = false;
  String? _errorMessage;

  List<HelpfulVideo> get videos => _videos;
  bool get isLoading => _isLoading;
  bool get isAddingVideo => _isAddingVideo;
  String? get errorMessage => _errorMessage;

  Future<void> loadVideos() async {
    _setLoading(true);
    _clearError();

    try {
      _videos = await _service.fetchAllVideos();
      _errorMessage = null;
    } catch (e) {
      print('Error loading videos: $e');
      _errorMessage = 'Failed to load videos. Please try again.';
      _videos = []; // Clear videos on error
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addVideo(HelpfulVideo video) async {
    _setAddingVideo(true);
    _clearError();

    try {
      await _service.addVideo(video);
      await loadVideos(); // Reload the videos list
      _errorMessage = null;
    } catch (e) {
      print('Error adding video: $e');
      _errorMessage = 'Failed to add video. Please check your connection and try again.';
      _setAddingVideo(false);
      notifyListeners();
    }
  }

  Future<void> updateVideo(String id, HelpfulVideo updatedVideo) async {
    _setLoading(true);
    _clearError();

    try {
      await _service.updateVideo(id, updatedVideo);
      await loadVideos(); // Reload the videos list
      _errorMessage = null;
    } catch (e) {
      print('Error updating video: $e');
      _errorMessage = 'Failed to update video. Please try again.';
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> deleteVideo(String id) async {
    _setLoading(true);
    _clearError();

    try {
      await _service.deleteVideo(id);
      await loadVideos(); // Reload the videos list
      _errorMessage = null;
    } catch (e) {
      print('Error deleting video: $e');
      _errorMessage = 'Failed to delete video. Please try again.';
      _setLoading(false);
      notifyListeners();
    }
  }

  // Helper methods
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setAddingVideo(bool value) {
    _isAddingVideo = value;
    if (!value) {
      notifyListeners();
    }
  }

  void _clearError() {
    _errorMessage = null;
  }

  // Clear any errors manually
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset the view model state
  void reset() {
    _videos.clear();
    _isLoading = false;
    _isAddingVideo = false;
    _errorMessage = null;
    notifyListeners();
  }

  // Get video by ID
  HelpfulVideo? getVideoById(String id) {
    try {
      return _videos.firstWhere((video) => video.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search videos by title or description
  List<HelpfulVideo> searchVideos(String query) {
    if (query.isEmpty) return _videos;

    final lowercaseQuery = query.toLowerCase();
    return _videos.where((video) {
      return video.title.toLowerCase().contains(lowercaseQuery) ||
          video.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}