import 'package:flutter/material.dart';
import '../data/models/helpful_video_model.dart';
import '../data/services/helpful_video_service.dart';

class HelpfulVideoViewModel extends ChangeNotifier {
  final HelpfulVideoService _service = HelpfulVideoService();

  List<HelpfulVideo> _videos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<HelpfulVideo> get videos => _videos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadVideos() async {
    _isLoading = true;
    notifyListeners();

    try {
      _videos = await _service.fetchAllVideos();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load videos';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addVideo(HelpfulVideo video) async {
    try {
      await _service.addVideo(video);
      await loadVideos();
    } catch (e) {
      _errorMessage = 'Failed to add video';
      notifyListeners();
    }
  }

  Future<void> updateVideo(String id) async {
    try {
      await _service.updateVideo(id);
      await loadVideos();
    } catch (e) {
      _errorMessage = 'Failed to update video';
      notifyListeners();
    }
  }

  Future<void> deleteVideo(String id) async {
    try {
      await _service.deleteVideo(id);
      await loadVideos();
    } catch (e) {
      _errorMessage = 'Failed to delete video';
      notifyListeners();
    }
  }
}
