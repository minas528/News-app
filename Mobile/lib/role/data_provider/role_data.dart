import 'dart:convert';

import 'package:Mobile/role/model/Role.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class RoleDataProvider{
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;

  RoleDataProvider({@required this.httpClient}) : assert(httpClient != null);


  Future<String> getTokenFromStorage() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "jwt_token");
    return token;
  }



  Future<Role> createMedia(Role role) async {
    final response = await httpClient.post(
      '$_baseUrl/api/role',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$getTokenFromStorage()'
      },
      body: jsonEncode(<String, dynamic>{
        'name': role.name,
      }),
    );
    print('response');
    if (response.statusCode == 200) {
      print('created');
      return Role.fromJson(jsonDecode(response.body));
    } else {
      print('falied');
      throw Exception('Failed to create role.');
    }
  }

  Future<List<Role>> getRoles() async {
    final response = await httpClient.get('$_baseUrl/api/role',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$getTokenFromStorage()'
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> roles = jsonDecode(response.body);
      final ppp = roles['data'] as List;
      return ppp.map((role) => Role.fromJson(role)).toList();
    } else {
      throw Exception('Failed to load roles');
    }
  }
  Future<Role> getRoleById(String id) async {
    final response = await httpClient.get('$_baseUrl/api/role/$id',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$getTokenFromStorage()'
        });

    if (response.statusCode == 200) {
      return Role.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load role');
    }
  }

  Future<void> deleteRole(String id) async {
    final response = await httpClient.delete(
      '$_baseUrl/api/media/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$getTokenFromStorage()'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete roles.');
    }
  }

  Future<void> updateRole(Role role) async {
    print(role);
    final  response = await httpClient.put(
        '$_baseUrl/api/media/${role.id}',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$getTokenFromStorage()'
        },
        body: jsonEncode(<String, dynamic>{
          'id': role.id,
          'name': role.name,
        }));
    print('response: ${response.body}');
    if (response.statusCode != 200) {
      throw Exception('Failed to update roles.');
    }
  }
}