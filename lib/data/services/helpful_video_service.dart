import '../../core/network/api_client.dart';
import '../models/helpful_video_model.dart';

class HelpfulVideoService {
  Future<List<HelpfulVideo>> fetchAllVideos() async {
    final response = await ApiClient.dio.get('/helpful-videos');
    return (response.data as List)
        .map((json) => HelpfulVideo.fromJson(json))
        .toList();
  }

  Future<void> addVideo(HelpfulVideo video) async {
    await ApiClient.dio.post('/helpful-videos', data: video.toJson());
  }

  Future<void> updateVideo(String id) async {
    await ApiClient.dio.put('/helpful-videos/$id');
  }

  Future<void> deleteVideo(String id) async {
    await ApiClient.dio.delete('/helpful-videos/$id');
  }
}
