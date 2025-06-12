import 'package:dio/dio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../data/models/helpful_video_model.dart';
import 'api_constants.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 90),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Set the Authorization token for authenticated API calls
  static void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear the Authorization token
  static void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }

  // Method to fetch YouTube video metadata using the youtube_explode_dart package
  static Future<HelpfulVideo> fetchYouTubeVideoMetadata(String videoUrl) async {
    try {
      final youtubeExplode = YoutubeExplode();
      final videoId = VideoId(videoUrl);
      final video = await youtubeExplode.videos.get(videoId);

      return HelpfulVideo(
        //id: videoId.value,
        title: video.title,
        description: video.description,
        url: videoUrl,
        thumbnail: video.thumbnails.highResUrl,  // Get high resolution thumbnail
      );
    } catch (e) {
      throw Exception('Failed to fetch YouTube video metadata: $e');
    }
  }
}
