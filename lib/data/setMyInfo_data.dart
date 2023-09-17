import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class My_Info {
  final String nickname;
  final String region;
  final String picture;
  // binary data로 변경

  My_Info(
      {
        required this.nickname,
        required this.region,
        required this.picture });

  factory My_Info.fromJson(Map<String, dynamic> json) {
    return My_Info(
      nickname: json["nickname"],
      region: json["region"],
      picture: json["picture"]
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "nickname": this.nickname,
      "region": this.region,
      "picture": this.picture
    };
  }
}