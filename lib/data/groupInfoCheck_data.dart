import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class GroupInfo_Check {
  final String nickname;
  final String region;
  final String profile;


  GroupInfo_Check(
      {
        required this.nickname,
        required this.region,
        required this.profile});


  factory GroupInfo_Check.fromJson(Map<String, dynamic> json) {
    return GroupInfo_Check(
      nickname: json["nickname"],
      region: json["region"],
      profile: json["profile_picture_path"]
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "nickname": this.nickname,
      "region" : this.region,
      "profile_picture_path" : this.profile,
    };
  }
}