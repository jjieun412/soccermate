import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class NewPw_Info {
  final String email;
  final String password;


  NewPw_Info(
      {
        required this.email,
        required this.password
      });

  factory NewPw_Info.fromJson(Map<String, dynamic> json) {
    return NewPw_Info(
        email: json["email"],
        password: json["password"]
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "email": this.email,
      "password": this.password
    };
  }
}