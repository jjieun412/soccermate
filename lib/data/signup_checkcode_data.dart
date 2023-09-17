import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class Signup_checkCode_Info {
  final String code;
  final String email;


  Signup_checkCode_Info(
      {
        required this.code,
        required this.email

      });

  factory Signup_checkCode_Info.fromJson(Map<String, dynamic> json) {
    return Signup_checkCode_Info(
        code: json["code"],
        email: json["email"]
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "code": this.code,
      "email": this.email,
    };
  }
}