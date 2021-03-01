import 'dart:convert';

import 'package:Mobile/news/model/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MediaDataProvider{
final _baseUrl = 'http://10.0.2.2:5000';
final http.Client httpClient;

MediaDataProvider({@required this.httpClient}) : assert(httpClient != null);
Future<String> getTokenFromStorage() async {
  final storage = new FlutterSecureStorage();
  String token = await storage.read(key: "jwt_token");
  return token;
}

Future<Media> createMedia(Media media) async {
  final response = await httpClient.post(
    '$_baseUrl/api/media',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '$getTokenFromStorage()'
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
        'Authorization': '$getTokenFromStorage()'
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
        'Authorization': '$getTokenFromStorage()'
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
      'Authorization': '$getTokenFromStorage()'
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
        'Authorization': '$getTokenFromStorage()'
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