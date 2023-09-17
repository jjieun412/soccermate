import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Token_Info {
  final String refresh_token;

  Token_Info(
      {
        required this.refresh_token });

  factory Token_Info.fromJson(Map<String, dynamic> json) {
    return Token_Info(
      refresh_token: json["refresh_token"],
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "refresh_token": this.refresh_token
    };
  }
}