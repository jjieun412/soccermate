import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Group_Info {
  final String picture;
  final String name;
  final String description;

  Group_Info(
      {
        required this.picture,
        required this.name,
        required this.description });

  factory Group_Info.fromJson(Map<String, dynamic> json) {
    return Group_Info(
        picture: json["picture"],
        name: json["name"],
        description: json["description"]
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "picture": this.picture,
      "name": this.name,
      "description": this.description,
    };
  }
}