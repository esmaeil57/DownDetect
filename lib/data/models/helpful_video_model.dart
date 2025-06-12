class HelpfulVideo {
  final String url;
  final String? thumbnail;
  final String? title;
  final String? description;

  HelpfulVideo({
    required this.url,
    this.thumbnail,
    this.title,
    this.description,
  });

  // Factory constructor for creating from YouTube API data
  factory HelpfulVideo.fromYouTubeData(Map<String, dynamic> data, String url) {
    final snippet = data['items'][0]['snippet'];
    final thumbnails = snippet['thumbnails'];

    return HelpfulVideo(
      url: url,
      thumbnail: thumbnails['high']['url'] ?? thumbnails['default']['url'],
      title: snippet['title'],
      description: snippet['description'],
    );
  }
}