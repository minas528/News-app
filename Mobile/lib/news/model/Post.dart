import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Post extends  Equatable {
  final String id;
  final String headLines;
  final String content;
  final String media;
  final File image;
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
    this.image
});

  @override
  List<Object> get props => [id, headLines, content, media, imgUrl, reporter, createdAt, image];

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      headLines: json['headlines'],
      content: json['content'],
      media: json['mediaId'],
      imgUrl: json['image'],
      reporter: json['reporterId'],
        createdAt:json['createdAt'],
      image: null

    );
  }
  @override
  String toString() => 'Post {id: $id, headlines: $headLines, content: $content, media: $media, imageUrl: $imgUrl, reporter: $reporter ,createdAt: $createdAt}';

}