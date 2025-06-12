import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HelpfulVideoDetailScreen extends StatelessWidget {
  final String videoUrl;

  const HelpfulVideoDetailScreen({Key? key, required this.videoUrl}) : super(key: key);

  // Extract YouTube video ID from URL
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

  @override
  Widget build(BuildContext context) {
    final videoId = _extractYouTubeVideoId(videoUrl);
    final hasVideoId = videoId != null;

    // Get highest quality thumbnail
    final thumbnailUrl = hasVideoId
        ? 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'
        : null;

    // Fallback to high quality if maxres doesn't exist
    final fallbackThumbnailUrl = hasVideoId
        ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg'
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Detail'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video thumbnail with play button overlay
            if (thumbnailUrl != null)
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    thumbnailUrl,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Try fallback thumbnail if maxres fails
                      return fallbackThumbnailUrl != null
                          ? Image.network(
                        fallbackThumbnailUrl,
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 220,
                            color: Colors.grey.shade200,
                            child: Icon(Icons.video_library, size: 64, color: Colors.grey),
                          );
                        },
                      )
                          : Container(
                        width: double.infinity,
                        height: 220,
                        color: Colors.grey.shade200,
                        child: Icon(Icons.video_library, size: 64, color: Colors.grey),
                      );
                    },
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                  ),
                ],
              ),

            // Video details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video URL
                  Text(
                    'YouTube URL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.link, color: Colors.blue, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            videoUrl,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Watch button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.play_circle_filled),
                      label: Text(
                        'Watch Video',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0E6C73),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        // Launch the video URL
                        if (await canLaunchUrlString(videoUrl)) {
                          await launchUrlString(videoUrl);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cannot open video URL'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}