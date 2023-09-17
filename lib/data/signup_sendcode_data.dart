import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class Signup_sendCode_Info {
  final String email;

  Signup_sendCode_Info(
      {
        required this.email });

  factory Signup_sendCode_Info.fromJson(Map<String, dynamic> json) {
    return Signup_sendCode_Info(
      email: json["email"],
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "email": this.email
    };
  }
}