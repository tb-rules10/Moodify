class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Video({required this.id, required this.title, required this.thumbnailUrl, required this.channelTitle});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['snippet']['channelTitle'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id/videoId': id,
        'snippet/title': title,
        'snippet/thumbnails/high/url': thumbnailUrl,
        'snippet/channelTitle': channelTitle,
      };
}

class RecentSearch {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  RecentSearch({required this.id, required this.channelTitle, required this.title, required this.thumbnailUrl});

  factory RecentSearch.fromJson(Map<String, dynamic> json) {
    return RecentSearch(
      id: json['videoId'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      channelTitle: json['channelTitle'],
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'videoId': id,
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'channelTitle': channelTitle,
      };
}
