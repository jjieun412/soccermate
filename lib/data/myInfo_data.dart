import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class MyInfo {
  final String nickname;
  final String region;
  final String profile;
  final int point;


  MyInfo(
      {
        required this.nickname,
        required this.region,
        required this.profile,
        required this.point });


  factory MyInfo.fromJson(Map<String, dynamic> json) {
    return MyInfo(
      nickname: json["nickname"],
      region: json["region"],
      profile: json["profile_picture_path"],
      point: json["point"],
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "nickname": this.nickname,
      "region" : this.region,
      "profile_picture_path" : this.profile,
      "point" : this.point
    };
  }
}