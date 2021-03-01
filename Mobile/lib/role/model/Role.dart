import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Role extends  Equatable {
  final String id;
  final String name;

  Role( {
    this.id,
    @required this.name
  });

  @override
  List<Object> get props => [id, name];

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['_id'],
      name: json['name'],

    );
  }
  @override
  String toString() => 'Post {id: $id, name: $name }';

}