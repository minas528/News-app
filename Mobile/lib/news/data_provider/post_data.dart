import 'dart:convert';
import 'dart:io';

import 'package:Mobile/news/model/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class PostDataProvider {
  final _baseUrl = 'http://10.6.223.96:5000';

  final http.Client httpClient;

  PostDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<String> getTokenFromStorage() async {
    final storage = new FlutterSecureStorage();
    String token = await storage.read(key: "jwt_token");
    return token;
  }

  Future<Post> createPost(Post post) async {
    File imageFile = post.image;
    try{
    var request = http.MultipartRequest(
      'POST', Uri.parse("http://10.6.223.96:5000/api/post"));
    Map<String, String> headers = {"Content-type": "multipart/form-data", 'Authorization': '$getTokenFromStorage()'};
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      imageFile.readAsBytesSync(),
      filename: path.basename(imageFile.path),
    ));
    request.headers.addAll(headers);
    request.fields.addAll({
      'headlines': post.headLines,
      'content': post.content,
      'media': post.media,
      'reporter': post.reporter,
    });
    print("request: " + request.toString());
    var responseStream = await request.send();
    // print("This is response:"+response.toString());
    final responseString = await responseStream.stream.bytesToString();
    if (responseStream.statusCode == 200) {
      print("response object");
      // var response = await http.Response.fromStream(responseStream);

      return Post.fromJson(jsonDecode(responseString));
    } else {
      print("errrrrrrrrr: "+responseString);
    }
    // return res.statusCode;
  } catch (e) {
  print("error happened");
  print(e);
  throw Exception(e);
  }
  }

  Future<List<Post>> getPosts() async {
    final response = await httpClient.get('$_baseUrl/api/post',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '$getTokenFromStorage()'
        });

    if (response.statusCode == 200) {
      // print(response.body);
      Map<String, dynamic> posts = jsonDecode(response.body);
      final ppp = posts['data'] as List;
      print(ppp);
      return ppp.map((post) => Post.fromJson(post)).toList();
    } else {
      print('wywywywywyw');
      throw Exception('Failed to load posts');
    }
  }

  Future<void> deletePost(String id) async {
    final response = await httpClient.delete(
      '$_baseUrl/api/post/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '$getTokenFromStorage()'
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updatePost(Post post) async {
    File imageFile = post.image;
    try{
      var request = http.MultipartRequest(
        'PUT',  Uri.parse("${_baseUrl}/post/${post.id}")
      );
      Map<String, String> headers = {"Content-type": "multipart/form-data"};

      request.files.add(http.MultipartFile.fromBytes('image', imageFile.readAsBytesSync(), filename: path.basename(imageFile.path),),);
      request.headers.addAll(headers);
      request.fields.addAll({
        'headlines': post.headLines,
        'content': post.content,
        'media': post.media,
        'reporter': post.reporter,
      });
      var responseStream = await request.send();
      final responseString = await responseStream.stream.bytesToString();
      if(responseStream.statusCode == 200){
        print('updated');
      }else{
        print(responseString);
      }
    }catch (e){
      throw Exception('Unalbe to update');
    }

  }
}
