import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class NewPw_checkCode_Info {
  final String code;
  final String email;

  NewPw_checkCode_Info(
      {
        required this.code,
        required this.email
      });

  factory NewPw_checkCode_Info.fromJson(Map<String, dynamic> json) {
    return NewPw_checkCode_Info(
        code: json["code"],
        email: json["email"]
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "code": this.code,
      "email": this.email
    };
  }
}