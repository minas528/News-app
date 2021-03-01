import 'dart:convert';

import 'package:Mobile/users/model/User.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthDataProvider {
  final _baseUrl = 'http://10.6.223.96:5000';
  final http.Client httpClient ;

  AuthDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<User> getCurrentUser() async {
    print('datatata');
    var user = getUserFromToken(await getToken());
    print(user);
    return user;
  }
  Future<String> getToken() async {
    print('did we get here');
    final storage = new FlutterSecureStorage();
    try {
      String token = await storage.read(key: "jwt_token");
      print('token'+ token);
      return token;
    }catch (e){

    }
    return null;
  }
  Future<User> signInWithUsernameAndPassword(String username, String password) async {
    print('and now');
    final response = await httpClient.post('$_baseUrl/api/users/login-user',
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
    final response = await http.post('$_baseUrl/api/users/register-user', headers: <String, String>{
    'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, String>{
      'username': user.username,
      'password': user.password,
      'email': user.email,
      'name':user.name,
    }));
    print('inside'+response.statusCode.toString());
    if (response.statusCode == 201){
      return true;
    }else {
      print('we got errr');
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
