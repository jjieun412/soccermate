import 'package:soccermate/repository/global_static_variable.dart';

class refresh_token_result{
  late final String? access_token;
  late final String? refresh_token;

  refresh_token_result.fromJson(Map<String, dynamic> jsonData)
  {
    this.access_token = jsonData[global_static_variable.ACCESS_TOKEN];
    this.refresh_token = jsonData[global_static_variable.REFRESH_TOKEN];
  }

}