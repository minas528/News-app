import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Post extends  Equatable {
  final String id;
  final String headLines;
  final String content;
  final String media;
  final String imgUrl;
  final String reporter;
  final String createdAt;

  Post( {
    this.id,
    @required this.headLines,
    @required this.content,
    @required this.media,
    @required this.imgUrl,
    @required this.reporter,
    this.createdAt,
});

  @override
  List<Object> get props => [id, headLines, content, media, imgUrl, reporter, createdAt];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      headLines: json['headlines'],
      content: json['content'],
      media: json['mediaId'],
      imgUrl: json['image'],
      reporter: json['reporterId'],
        createdAt:json['createdAt']

    );
  }
  @override
  String toString() => 'Post {id: $id, headlines: $headLines, content: $content, media: $media, imageUrl: $imgUrl, reporter: $reporter ,createdAt: $createdAt}';

}