class HelpfulVideo {
  final String id;
  final String title;
  final String description;
  final String url;
  final String? thumbnail;

  HelpfulVideo({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    this.thumbnail,
  });

  factory HelpfulVideo.fromJson(Map<String, dynamic> json) => HelpfulVideo(
    id: json['_id'],
    title: json['title'],
    description: json['description'],
    url: json['url'],
    thumbnail: json['thumbnail'],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "url": url,
    "thumbnail": thumbnail,
  };
}
