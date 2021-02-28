import 'dart:convert';

import 'package:Mobile/auth/model/Auth.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthDataProvider {
  final _baseUrl = 'http://10.0.2.2:5000';
  final http.Client httpClient;
  final token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjAwMDQ0YWJjMzIyYzdlYTExYzA4OWJhIiwicm9sZSI6InVzZXIiLCJ1c2VybmFtZSI6Im1pbmFzNTI4MiIsImVtYWlsIjoibWluYWxlbS41M2RAZ21haWwuY29tIiwiaWF0IjoxNjEzMTUxODAxLCJleHAiOjE2MTM3NTY2MDF9.m0-1vqNPgeYCiqx5STbiIOQMGGoK4jP4am9rJRpUm5k';

  AuthDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<User> getCurrentUser() async {
    var user = getUserFromToken(await getToken());
    return user;
  }
  Future<String> getToken() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "jwt_token");
    return token;
  }
  Future<User> signInWithUsernameAndPassword(String username, String password) async {
    final response = await httpClient.post('$_baseUrl/api/users/user_login',
        headers: <String,String>{'Content-Type': 'application/json',},
    body: jsonEncode(<String,String>{'username':username,'password':password}));
    if (response.statusCode == 200){
      final Map<String,dynamic> data = jsonDecode(response.body);
      storeJwt(data['token']);
      return User.fromJson(data);
    }
  }
  Future<bool> signUpWithUsernameAndPassword(User user) async{
    print(user);
    final response = await http.post('$_baseUrl/api/users/user_register', headers: <String, String>{
    'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'username': user.username,
    'password': user.password,
    'email': user.email,
      'name':user.name,
    }));

    if (response.statusCode == 201){
      return true;
    }else {
      throw Exception('Wrong username or password');
    }
  }
  @override
  Future<void> signOut(){
    return null;
  }

  void storeJwt(token) async{
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'jwt_token', value: token);
  }

  User getUserFromToken(token){
    Map<String, dynamic> payload = Jwt.parseJwt(token);
    bool isExpired = Jwt.isExpired(token);
    print(isExpired);
    if(!isExpired){
      var username = payload['username'];
      var email = payload['email'];
      var role = payload['role'];
      var id = payload['user_id'];
      User result = User(username: username, email: email,role: role,id: id);
      return result;
    }else{
      return null;
    }
  }
}
