import 'dart:convert';

import 'package:Mobile/post/model/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostDataProvider {
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;
  final token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjAwMDQ0YWJjMzIyYzdlYTExYzA4OWJhIiwicm9sZSI6InVzZXIiLCJ1c2VybmFtZSI6Im1pbmFzNTI4MiIsImVtYWlsIjoibWluYWxlbS41M2RAZ21haWwuY29tIiwiaWF0IjoxNjEzMTUxODAxLCJleHAiOjE2MTM3NTY2MDF9.m0-1vqNPgeYCiqx5STbiIOQMGGoK4jP4am9rJRpUm5k';

  PostDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Post> createPost(Post post) async {
    final response = await httpClient.post(
      '$_baseUrl/api/post',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
      body: jsonEncode(<String, dynamic>{
        'headlines': post.headLines,
        'content': post.content,
        'image': post.imgUrl,
        'media': post.media,
        'reporter': post.reporter,
      }),
    );
    print('response');
    if (response.statusCode == 200) {
      print('created');
      return Post.fromJson(jsonDecode(response.body));
    } else {
      print('falied');
      throw Exception('Failed to create post.');
    }
  }

  Future<List<Post>> getPosts() async {
    final response = await httpClient.get('$_baseUrl/api/post',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> posts = jsonDecode(response.body);
      final ppp = posts['data'] as List;
      return ppp.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> deletePost(String id) async {
    final response = await httpClient.delete(
      '$_baseUrl/api/post/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updatePost(Post post) async {
    final  response = await httpClient.put(
        '$_baseUrl/api/post/${post.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        },
        body: jsonEncode(<String, dynamic>{
          'id': post.id,
          'headlines': post.headLines,
          'content': post.content,
          'image': post.imgUrl,
          'media': post.media,
          'reporter': post.reporter,
        }));
    print('response: ${response.statusCode}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update course.');
    }
  }
}
