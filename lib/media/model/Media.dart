import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Media extends  Equatable {
  final String id;
  final String name;
  final String email;
  final String website;

  Media( {
    this.id,
    @required this.name,
    @required this.email,
    @required this.website,
  });

  @override
  List<Object> get props => [id, name, email, website];

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        website: json['website'],

    );
  }
  @override
  String toString() => 'Post {id: $id, name: $name, email: $email, website: $website}';

}