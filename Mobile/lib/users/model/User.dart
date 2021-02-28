import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends  Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String username;
  final String password;

  User( {
    this.id,
    @required this.name,
    @required this.email,
    @required this.role,
    @required this.username,
    @required this.password
  });

  @override
  List<Object> get props => [id, name, email, role, username,password];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      username: json['username'],
      password: json['password'],
    );
  }
  @override
  String toString() => 'Post {id: $id, name: $name, email: $email, role: $role, username: $username,}';

}