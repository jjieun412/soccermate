import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class MyInfo_Edit_Nick {
  final String nickname;


  MyInfo_Edit_Nick(
      {
        required this.nickname });

  factory MyInfo_Edit_Nick.fromJson(Map<String, dynamic> json) {
    return MyInfo_Edit_Nick(
        nickname: json["nickname"],
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "nickname": this.nickname
    };
  }
}