import 'package:flutter/material.dart';
import '../data/models/helpful_video_model.dart';
import '../data/services/helpful_video_service.dart';

class HelpfulVideoViewModel extends ChangeNotifier {
  final HelpfulVideoService _service = HelpfulVideoService();
  List<HelpfulVideo> _videos = [];
  bool _isLoading = false;
  bool _isAddingVideo = false;
  String? _errorMessage;
  bool _isInitialized = false;

  List<HelpfulVideo> get videos => _videos;
  bool get isLoading => _isLoading;
  bool get isAddingVideo => _isAddingVideo;
  String? get errorMessage => _errorMessage;

  // Initialize the view model
  Future<void> initialize() async {
    if (_isInitialized) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _service.initialize();
      _videos = await _service.fetchAllVideos();
      _isInitialized = true;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to initialize: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load all videos
  Future<void> loadVideos() async {
    if (!_isInitialized) {
      await initialize();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      _videos = await _service.fetchAllVideos();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load videos: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new video with metadata
  Future<void> addVideo(String url) async {
    if (!_isInitialized) {
      await initialize();
    }

    _isAddingVideo = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final video = await _service.addVideo(url);

      // No need to add to _videos list manually as we'll reload the whole list
      await loadVideos();

    } catch (e) {
      _errorMessage = 'Failed to add video: ${e.toString()}';
      notifyListeners();
    } finally {
      _isAddingVideo = false;
      notifyListeners();
    }
  }

  // Clear any errors
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}