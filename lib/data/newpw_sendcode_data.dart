import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class NewPw_sendCode_Info {
  final String email;

  NewPw_sendCode_Info(
      {
        required this.email });

  factory NewPw_sendCode_Info.fromJson(Map<String, dynamic> json) {
    return NewPw_sendCode_Info(
      email: json["email"],
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "email": this.email
    };
  }
}
