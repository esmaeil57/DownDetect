import '../../core/network/api_client.dart';
import '../models/helpful_video_model.dart';

class HelpfulVideoService {
  Future<List<HelpfulVideo>> fetchAllVideos() async {
    try {
      final response = await ApiClient.dio.get('/helpful-videos');

      if (response.data is List) {
        return (response.data as List)
            .map((json) => HelpfulVideo.fromJson(json))
            .toList();
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error fetching videos: $e');
      throw Exception('Failed to fetch videos: ${e.toString()}');
    }
  }

  Future<HelpfulVideo> addVideo(HelpfulVideo video) async {
    try {
      final response = await ApiClient.dio.post(
        '/helpful-videos',
        data: video.toJson(),
      );

      if (response.data != null) {
        return HelpfulVideo.fromJson(response.data);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error adding video: $e');
      throw Exception('Failed to add video: ${e.toString()}');
    }
  }

  Future<HelpfulVideo> updateVideo(String id, HelpfulVideo video) async {
    try {
      final response = await ApiClient.dio.put(
        '/helpful-videos/$id',
        data: video.toJson(),
      );

      if (response.data != null) {
        return HelpfulVideo.fromJson(response.data);
      } else {
        throw Exception('Invalid response format');
      }
    } catch (e) {
      print('Error updating video: $e');
      throw Exception('Failed to update video: ${e.toString()}');
    }
  }

  Future<void> deleteVideo(String id) async {
    try {
      await ApiClient.dio.delete('/helpful-videos/$id');
    } catch (e) {
      print('Error deleting video: $e');
      throw Exception('Failed to delete video: ${e.toString()}');
    }
  }

  Future<HelpfulVideo?> getVideoById(String id) async {
    try {
      final response = await ApiClient.dio.get('/helpful-videos/$id');

      if (response.data != null) {
        return HelpfulVideo.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error fetching video by ID: $e');
      throw Exception('Failed to fetch video: ${e.toString()}');
    }
  }
}