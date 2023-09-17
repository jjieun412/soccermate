import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class MyInfo_Edit_Region {
  final String region;

  MyInfo_Edit_Region(
      {
        required this.region });

  factory MyInfo_Edit_Region.fromJson(Map<String, dynamic> json) {
    return MyInfo_Edit_Region(
        region: json["region"]
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "region": this.region
    };
  }
}