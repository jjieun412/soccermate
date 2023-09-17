import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:soccermate/data/refresh_token_result.dart';
import 'package:soccermate/repository/global_static_variable.dart';

import '../../data/token_data.dart';
import '../../exception/TokenErrorException.dart';

class TokenRefresher
{
  static final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<bool> expired() async{

    String? accessToken = await _getAccessTokenFr();
    DateTime? expiryDate = Jwt.getExpiryDate(accessToken!);

    print(expiryDate);

    DateTime curr = DateTime.now();

    // true라면 refresh token으로 재설정, false면 access token 사용!
    return !curr.isBefore(expiryDate?? DateTime.now() );
  }

  static Future<int> getUserId() async
  {
     String userId = await storage.read(key: "userId") ??"0";
     return int.parse(userId);
  }


  // refresh token으로 재설정
  static Future<refresh_token_result> token_info() async {

    String? refreshToken = await getRefreshToken();
    Token_Info token_info = new Token_Info(refresh_token: refreshToken!);
    Map<String ,dynamic> tokenInfo = token_info.toJson();



    late Response result;
    Map<String, String> header = {
      "Content-type" : "application/json"
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + global_static_variable.RESET_TOKEN);
      result = await post(
          url, body: json.encode(tokenInfo), headers: header);

      print("reset_token : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(result.body);


        refresh_token_result tokenResult = refresh_token_result.fromJson(res);
        saveTokens(accessToken: tokenResult.access_token!, refreshToken: tokenResult.refresh_token!, userId: await getUserId());

        return tokenResult;
      }

    } catch(e) {
      print(e);

    }
    throw TokenErrorException("다시 로그인 해주세요.");
  }




  static Future<String?> getRefreshToken()
  {
    print("get refreshToken Called!");
    return storage.read(key: global_static_variable.REFRESH_TOKEN);
  }



  static Future<String?> _getAccessTokenFr()
  {
    print("_getAccessTokenFr called!");
    return storage.read(key: global_static_variable.ACCESS_TOKEN);
  }



  static Future<String?> getAccessToken() async{
    print("getAccessToken calaled!");
    late String accessToken;

    if(await TokenRefresher.expired())
    {
      print("token is expired!");
      refresh_token_result tokenResult = await TokenRefresher.token_info();
      accessToken = await tokenResult.access_token!;
    }
    else{

      print("token is not expired");
      accessToken = (await TokenRefresher._getAccessTokenFr())!;
    }

    return accessToken;
  }

  static Future<void> saveTokens({required String accessToken, required String refreshToken, required int userId}) async
  {
    try{
      await storage.write(key: "userId", value: userId.toString());
      await storage.write(key: global_static_variable.ACCESS_TOKEN, value:accessToken);
      await storage.write(key: global_static_variable.REFRESH_TOKEN, value:refreshToken);
    }
    catch(e)
    {
      print(e);
    }
  }
}
