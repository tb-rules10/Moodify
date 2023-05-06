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

class Songs {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  Songs({required this.id, required this.channelTitle, required this.title, required this.thumbnailUrl});

  factory Songs.fromJson(Map<String, dynamic> json) {
    return Songs(
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


class AlbumCards {
  final String id;
  final String title;
  final String? subtitle;
  final String iconUrl;

  AlbumCards({required this.id, required this.title, required this.iconUrl, this.subtitle});
}

var dailyMix = [
  AlbumCards(id: "1", title: "Daily Mix 1", iconUrl: "https://upload.wikimedia.org/wikipedia/en/thumb/2/26/Black_Pink_-_Square_Up_artwork.png/220px-Black_Pink_-_Square_Up_artwork.png"),
  AlbumCards(id: "2", title: "Daily Mix 2", iconUrl: 'https://i.scdn.co/image/ab67616d0000b273e960ebdd55eff9ee95dc85fb'),
  AlbumCards(id: "3", title: "Daily Mix 3", iconUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLyC_WrqH3dfkrifv9Uj494gjXGUzDDb4ydQ&usqp=CAU'),
  AlbumCards(id: "4", title: "Daily Mix 4", iconUrl: 'https://www.musicinminnesota.com/wp-content/uploads/2022/01/Photo-from-Adobe-Stock.jpg'),
  AlbumCards(id: "5", title: "Daily Mix 5",  iconUrl: 'https://cdn.dribbble.com/users/905938/screenshots/3441423/cover-4-vinyl-dribbble.jpg'),
];

var albums = [
  AlbumCards(id: "1", title: "Desi Hip-Hop", iconUrl: "https://e1.pxfuel.com/desktop-wallpaper/866/656/desktop-wallpaper-hip-hop-rapper-in-pinterest-krsna.jpg"),
  AlbumCards(id: "2", title: "English Hip-Hop", iconUrl: 'https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/61LR7TXsUoL.jpg'),
  AlbumCards(id: "3", title: "English Songs", iconUrl: 'https://upload.wikimedia.org/wikipedia/en/a/a5/Closer_%28featuring_Halsey%29_%28Official_Single_Cover%29_by_The_Chainsmokers.png'),
  AlbumCards(id: "4", title: "Classical Hindi Songs", iconUrl: 'https://img.wynk.in/unsafe/200x200/filters:no_upscale():strip_exif():format(jpg)/http://s3.ap-south-1.amazonaws.com/discovery-prod-arsenal/arsenal/artworks/64183928c91f9d41080a2364/COLLECTION_464298048435.png'),
];
