import 'package:flutter/material.dart';

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
}

class RecentSearch {
  final String id;
  final String title;
  final String thumbnailUrl;

  RecentSearch({required this.id, required this.title, required this.thumbnailUrl});

  factory RecentSearch.fromJson(Map<String, dynamic> json) {
    return RecentSearch(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'],
    );
  }
}
