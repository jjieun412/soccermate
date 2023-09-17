import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';



class Signup_Info {
  final String email;
  final String password;

  Signup_Info(
      {
        required this.email,
        required this.password
      });

  factory Signup_Info.fromJson(Map<String, dynamic> json) {
    return Signup_Info(
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