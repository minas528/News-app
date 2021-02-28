import 'dart:convert';

import 'package:Mobile/post/model/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MediaDataProvider{
final _baseUrl = 'http://192.168.43.42:5000';
final http.Client httpClient;
final token =
'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjAwMDQ0YWJjMzIyYzdlYTExYzA4OWJhIiwicm9sZSI6InVzZXIiLCJ1c2VybmFtZSI6Im1pbmFzNTI4MiIsImVtYWlsIjoibWluYWxlbS41M2RAZ21haWwuY29tIiwiaWF0IjoxNjEzMTUxODAxLCJleHAiOjE2MTM3NTY2MDF9.m0-1vqNPgeYCiqx5STbiIOQMGGoK4jP4am9rJRpUm5k';

MediaDataProvider({@required this.httpClient}) : assert(httpClient != null);

Future<Media> createMedia(Media media) async {
  final response = await httpClient.post(
    '$_baseUrl/api/media',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$token'
    },

    body: jsonEncode(<String, dynamic>{
      'name': media.name,
      'email': media.email,
      'website': media.website,
    }),
  );
  print('response');
  if (response.statusCode == 200) {
    print('created');
    return Media.fromJson(jsonDecode(response.body));
  } else {
    print('falied');
    throw Exception('Failed to create post.');
  }
}

Future<List<Media>> getMedias() async {
  final response = await httpClient.get('$_baseUrl/api/media',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      });

  if (response.statusCode == 200) {
    Map<String, dynamic> medias = jsonDecode(response.body);
    final ppp = medias['data'] as List;
    return ppp.map((media) => Media.fromJson(media)).toList();
  } else {
    throw Exception('Failed to load posts');
  }
}
Future<Media> getMediaById(String id) async {
  final response = await httpClient.get('$_baseUrl/api/media/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      });

  if (response.statusCode == 200) {
    return Media.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load posts');
  }
}

Future<void> deleteMedia(String id) async {
  final response = await httpClient.delete(
    '$_baseUrl/api/media/$id',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$token'
    },
  );
  if (response.statusCode != 200) {
    throw Exception('Failed to delete course.');
  }
}

Future<void> updateMedia(Media media) async {
  print(media);
  final  response = await httpClient.put(
      '$_baseUrl/api/media/${media.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
      body: jsonEncode(<String, dynamic>{
        'id': media.id,
        'name': media.name,
        'email': media.email,
        'website': media.website,
      }));
  print('response: ${response.body}');
  if (response.statusCode != 200) {
    throw Exception('Failed to update course.');
  }
}
}