import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Login_Info {
  final String email;
  final String password;

  Login_Info(
  {
    required this.email,
    required this.password });

  factory Login_Info.fromJson(Map<String, dynamic> json) {
    return Login_Info(
        email: json["email"],
        password: json["password"],
    );
  }

  Map<String ,dynamic> toJson()
  {
    return {
      "email": this.email,
      "password": this.password
    };
  }
}

