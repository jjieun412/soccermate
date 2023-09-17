import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:binary/binary.dart';


class MyInfo_Edit_Pic {
  final String picture;
  // binary data 로 변경


  MyInfo_Edit_Pic(
      {
        required this.picture });

  factory MyInfo_Edit_Pic.fromJson(Map<String, dynamic> json) {
    return MyInfo_Edit_Pic(
        picture: json["picture"]
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "picture": this.picture
    };
  }
}
