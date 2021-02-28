import 'dart:convert';

import 'package:Mobile/users/model/User.dart';
import 'package:Mobile/users/model/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UserDataProvider{
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;
  final token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjAwMDQ0YWJjMzIyYzdlYTExYzA4OWJhIiwicm9sZSI6InVzZXIiLCJ1c2VybmFtZSI6Im1pbmFzNTI4MiIsImVtYWlsIjoibWluYWxlbS41M2RAZ21haWwuY29tIiwiaWF0IjoxNjEzMTUxODAxLCJleHAiOjE2MTM3NTY2MDF9.m0-1vqNPgeYCiqx5STbiIOQMGGoK4jP4am9rJRpUm5k';

  UserDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<User> createMedia(User user) async {
    final response = await httpClient.post(
      '$_baseUrl/api/users/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': user.name,
        'email': user.email,
        'role': user.role,
        'username' : user.username,
        'password': user.password
      }),
    );
    print('response');
    if (response.statusCode == 200) {
      print('created');
      return User.fromJson(jsonDecode(response.body));
    } else {
      print('falied');
      throw Exception('Failed to create post.');
    }
  }

  Future<List<User>> getMedias() async {
    final response = await httpClient.get('$_baseUrl/api/users',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> users = jsonDecode(response.body);
      final ppp = users['data'] as List;
      return ppp.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
  Future<User> getMediaById(String id) async {
    final response = await httpClient.get('$_baseUrl/api/users/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        });

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<void> deleteMedia(String id) async {
    final response = await httpClient.delete(
      '$_baseUrl/api/users/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$token'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateMedia(User user) async {
    print(user);
    final  response = await httpClient.put(
        '$_baseUrl/api/users/${user.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$token'
        },
        body: jsonEncode(<String, dynamic>{
          'id': user.id,
          'name': user.name,
          'email': user.email,
          'role': user.role,
          'username': user.username,
          'password' : user.password,
        }));
    print('response: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update course.');
    }
  }
}