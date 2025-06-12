import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/helpful_video_model.dart';

class HelpfulVideoService {
  // Store your API key securely in production environments
  static const String apiKey = 'YOUR_YOUTUBE_API_KEY';
  static const String _videosStorageKey = 'helpful_videos';

  List<HelpfulVideo> _videos = [];

  List<HelpfulVideo> get videos => _videos;

  // Initialize service and load saved videos
  Future<void> initialize() async {
    await _loadSavedVideos();
  }

  // Load saved videos from local storage
  Future<void> _loadSavedVideos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? savedVideosJson = prefs.getString(_videosStorageKey);

      if (savedVideosJson != null) {
        final List<dynamic> decodedList = jsonDecode(savedVideosJson);
        _videos = decodedList
            .map((videoJson) => _videoFromJson(videoJson))
            .toList();
      }
    } catch (e) {
      print('Error loading saved videos: $e');
      // If there's an error, start with an empty list
      _videos = [];
    }
  }

  // Save videos to local storage
  Future<void> _saveVideos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<Map<String, dynamic>> videosJson = _videos
          .map((video) => {
        'url': video.url,
        'thumbnail': video.thumbnail,
        'title': video.title,
        'description': video.description,
      })
          .toList();

      await prefs.setString(_videosStorageKey, jsonEncode(videosJson));
    } catch (e) {
      print('Error saving videos: $e');
    }
  }

  // Convert JSON to HelpfulVideo
  HelpfulVideo _videoFromJson(Map<String, dynamic> json) {
    return HelpfulVideo(

      url: json['url'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      description: json['description'],
    );
  }

  // Fetch all videos that have been added
  Future<List<HelpfulVideo>> fetchAllVideos() async {
    return _videos;
  }

  // Extract video ID from various YouTube URL formats
  String? _extractYouTubeVideoId(String url) {
    RegExp regExp = RegExp(
      r'^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*',
      caseSensitive: false,
      multiLine: false,
    );

    Match? match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 7) {
      String? id = match.group(7);
      return id!.length == 11 ? id : null;
    }
    return null;
  }

  // Get video metadata without API (fallback method)
  HelpfulVideo _getVideoMetadataWithoutApi(String url) {
    final videoId = _extractYouTubeVideoId(url);
    if (videoId == null) {
      throw Exception('Invalid YouTube URL');
    }

    // Create a basic HelpfulVideo with data we can derive without the API
    return HelpfulVideo(
      url: url,
      thumbnail: 'https://img.youtube.com/vi/$videoId/hqdefault.jpg',
      title: 'YouTube Video',
      description: 'Video ID: $videoId',
    );
  }

  // Fetch video metadata from YouTube using its API
  Future<HelpfulVideo> getVideoMetadata(String url) async {
    final videoId = _extractYouTubeVideoId(url);
    if (videoId == null) {
      throw Exception('Invalid YouTube URL');
    }

    // Check if we have a valid API key
    if (apiKey == 'YOUR_YOUTUBE_API_KEY') {
      // If no API key, use fallback method
      return _getVideoMetadataWithoutApi(url);
    }

    try {
      final apiUrl = Uri.parse(
          'https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$apiKey&part=snippet');

      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['items'] == null || data['items'].isEmpty) {
          throw Exception('Video not found');
        }

        return HelpfulVideo.fromYouTubeData(data, url);
      } else {
        // If API request fails, use fallback method
        return _getVideoMetadataWithoutApi(url);
      }
    } catch (e) {
      // If any errors occur, use fallback method
      return _getVideoMetadataWithoutApi(url);
    }
  }

  // Add a new video by its URL
  Future<HelpfulVideo> addVideo(String url) async {
    // Get video metadata and add to the list
    final video = await getVideoMetadata(url);
    _videos.add(video);
    await _saveVideos(); // Save to local storage
    return video;
  }
}