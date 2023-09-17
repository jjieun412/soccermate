import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import 'dart:async';
import 'dart:convert';

import 'package:soccermate/data/login_data.dart';
import 'package:soccermate/data/refresh_token_result.dart';
import 'package:soccermate/data/signup_sendcode_data.dart';
import 'package:soccermate/data/user_dto.dart';
import 'package:soccermate/exception/CodeNotSentException.dart';
import 'package:soccermate/exception/IncorrectCodeException.dart';
import 'package:soccermate/exception/EmailDuplicatedException.dart';
import 'package:soccermate/exception/LogInFailedException.dart';
import 'package:soccermate/exception/SetMyInfoDataFailedException.dart';
import 'package:soccermate/repository/global_static_variable.dart';
import 'package:soccermate/repository/util/TokenRefresher.dart';

import '../data/myInfo_data.dart';
import '../data/newpw_checkcode_data.dart';
import '../data/newpw_data.dart';
import '../data/newpw_sendcode_data.dart';
import '../data/setMyInfo_data.dart';
import '../data/signup_checkcode_data.dart';
import '../data/signup_data.dart';
import '../exception/CodeNotCheckException.dart';
import '../exception/EmailUnformatException.dart';
import '../exception/PWUnformatException.dart';



class User_Repository {


  //final FlutterSecureStorage storage = FlutterSecureStorage();

  // 로그인
  static const Login = "/user/login";
  static const GoogleLogin = "/oauth2/authorization/google";

  // 회원가입
  static const SignUp = "/user";
  static const Send_Code_SignUp= "/user/signup/emailsend";
  static const Check_Code_SignUp= "/user/signup/emailcodecheck";

  // 비밀번호 재설정
  static const Send_Code_PW = "/user/password/emailsend";
  static const Check_Code_PW= "/user/password/emailcodecheck";
  static const Set_PW = "/user/password";

  //마이페이지 조회 -> "/user"

  //유저 정보 설정
  static const User_Info = "/user";

  //유저 정보 수정
  static const User_Nick_Edit = "/user/nickname";
  static const User_Location_Edit = "/user/region";
  static const User_Pic_Edit = "/user/profile_picture";



  //signup send code token   :   회원가입
   String? signUpSendCodeToken;
   String? signUpCheckCodeToken;

   // newPw send/check code token  : 비번 재설정
   String? newPwSendCodeToken;
   String? newPwCheckCodeToken;

   // access token, refresh token  : 로그인


  static final User_Repository _totalRepository = User_Repository._privTotalRepository();
  factory User_Repository()
  {
    return _totalRepository;
  }

  User_Repository._privTotalRepository()
  {

  }







 // 로그인
  Future<user_dto> login_info(Login_Info login_info) async {
    Map<String ,dynamic> log_info = login_info.toJson();

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json"
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + Login);
      result = await http.post(
        url, body: json.encode(log_info), headers: header);

      print("login : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(result.body);
        String accessToken = res["access_token"];
        String refreshToken = res["refresh_token"];
        int userId_temp = int.parse(res["user_id"].toString());



        if(accessToken == null)
          {
            throw LoginFailedException("로그인 실패");
          }

        TokenRefresher.saveTokens(accessToken: accessToken, refreshToken: refreshToken, userId: userId_temp);
        String refined_access_token = accessToken!.substring(7);
        Map<String, dynamic> payload = Jwt.parseJwt(refined_access_token);

        String role = payload["role"];
        int userId = payload["subject"] ?? 0;

        return user_dto(role: role, userId: userId);


      } else {
        throw LoginFailedException("유효하지 않은 로그인 정보 입니다. 다시 입력해주세요.");
      }
    } catch(e) {
      print(e);
      throw LoginFailedException("유효하지 않은 로그인 정보 입니다. 다시 입력해주세요.");
    }
  }


  /*
  bool expired(){
    if(accessToken == null) { return false;}
    DateTime? expiryDate = Jwt.getExpiryDate(accessToken!);

    print(expiryDate);

    DateTime curr = DateTime.now();

    // true라면 refresh token으로 재설정, false면 access token 사용!
    return !curr.isBefore(expiryDate?? DateTime.now() );
  }


  // refresh token으로 재설정
   Future<Map<String, dynamic>> token_info() async {
     if(refreshToken == null) {
       //throw TokenErrorException("다시 로그인 해주세요.");  // 팝업으로
     }

     Token_Info token_info = new Token_Info(refresh_token: refreshToken!);
     Map<String ,dynamic> tokenInfo = token_info.toJson();



     late http.Response result;
     Map<String, String> header = {
       "Content-type" : "application/json"
     };

     try {
       Uri url = Uri.parse(BaseUrl + Reset_Token);
       result = await http.post(
           url, body: json.encode(tokenInfo), headers: header);

       print("reset_token : ");
       print(result.body);

       if(result.statusCode == 200) {
         Map<String, dynamic> res = json.decode(result.body);
         accessToken = res["access_token"];
         refreshToken = res["refresh_token"];
         return res;
       } else if(result.statusCode == 401) {
         throw TokenErrorException("다시 로그인 해주세요.");

       } else {
         return {};
       }
     } catch(e) {
       print(e);
       return {};
     }
   }

   */


   // 회원가입 - 인증번호 전송
   Future<Map<String, dynamic>> signup_SendCode_info(Signup_sendCode_Info signup_sendCode_info) async {
     Map<String ,dynamic> signSendCode_info = signup_sendCode_info.toJson();

     late http.Response result;
     Map<String, String> header = {
       "Content-type" : "application/json"
     };

     try {
       Uri url = Uri.parse(global_static_variable.BaseUrl + Send_Code_SignUp);
       result = await http.post(
           url, body: json.encode(signSendCode_info), headers: header);

       print("signup_sendCode : ");
       print(result.body);

       if(result.statusCode == 200) {
         Map<String, dynamic> res = json.decode(result.body);
         signUpSendCodeToken = res["token"];
         return res;
       } else if(result.statusCode == 400) {
         throw EmailUnformatException("유효하지 않은 이메일 입니다. 다시 입력해주세요.");
       }
       else if(result.statusCode == 409) {
         throw EmailDuplicatedException("이미 존재하는 이메일 입니다. 다시 입력해주세요.");
       } else {
         return {};
       }
     } catch(e) {
       return {};
     }
   }


   // 회원가입 인증번호 확인
   Future<Map<String, dynamic>> signup_CheckCode_info(Signup_checkCode_Info signup_checkCode_info) async {
     Map<String ,dynamic> signCheckCode_info = signup_checkCode_info.toJson();
     signCheckCode_info.putIfAbsent("token", () => signUpSendCodeToken);

     if(signUpSendCodeToken == null) {
       throw CodeNotSentException("인증번호 전송 버튼을 눌러주세요.");
     }

     late http.Response result;
     Map<String, String> header = {
       "Content-type" : "application/json"
     };

     try {
       Uri url = Uri.parse(global_static_variable.BaseUrl + Check_Code_SignUp);
       result = await http.post(
           url, body: json.encode(signCheckCode_info), headers: header);

       print("signup_checkCode : ");
       print(result.body);

       if(result.statusCode == 200) {
         Map<String, dynamic> res = json.decode(result.body);
         signUpCheckCodeToken = res["token"];
         return res;
       } else if(result.statusCode == 400) {
         return{};
       }
       else if(result.statusCode == 401) {
         throw IncorrectCodeException("유효하지 않은 인증번호 입니다. 다시 입력해주세요.");
       } else {
         return {};
       }
     } catch(e) {
       return {};
     }
   }


   // 회원가입 완료
   Future<Map<String, dynamic>> signup_info(Signup_Info signup_info) async {
     Map<String ,dynamic> sign_info = signup_info.toJson();
     sign_info.putIfAbsent("token", () => signUpCheckCodeToken);

     if(signUpCheckCodeToken == null) {
       throw CodeNotCheckException("인증번호 확인 버튼을 눌러주세요.");
     }

     late http.Response result;
     Map<String, String> header = {
       "Content-type" : "application/json"
     };

     try {
       Uri url = Uri.parse(global_static_variable.BaseUrl + SignUp);
       result = await http.post(
           url, body: json.encode(sign_info), headers: header);

       print("signup : ");
       print(result.body);

       if(result.statusCode == 201) {
         Map<String, dynamic> res = json.decode(result.body);
         return res;
       } else if(result.statusCode == 400) {
         throw EmailUnformatException("유효하지 않은 이메일 또는 비밀번호 입니다. 다시 확인해주세요.");
       }
       else if(result.statusCode == 401) {
         throw IncorrectCodeException("유효하지 않은 인증번호 입니다. 다시 확인해주세요.");
       } else if(result.statusCode == 409) {
         throw EmailDuplicatedException("이미 존재하는 이메일 입니다. 다시 입력해주세요.");
       } else {
         return {};
       }
     } catch(e) {
       return {};
     }
   }


  // 비번재설정 - 인증번호 전송
  Future<Map<String, dynamic>> pw_SendCode_info(NewPw_sendCode_Info newPw_sendCode_info) async {
    Map<String ,dynamic> PWSendCode_info = newPw_sendCode_info.toJson();

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json"
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + Send_Code_PW);
      result = await http.post(
          url, body: json.encode(PWSendCode_info), headers: header);

      print("newPW_sendCode : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(result.body);
        newPwSendCodeToken = res["token"];
        return res;
      } else if(result.statusCode == 400) {
        throw PWUnformatException("유효하지 않은 비밀번호 입니다. 다시 입력해주세요.");
      }
      else if(result.statusCode == 409) {
        throw EmailDuplicatedException("가입되지 않은 이메일 입니다. 다시 입력해주세요.");
      } else {
        return {};
      }
    } catch(e) {
      return {};
    }
  }


  // 비번재설정 인증번호 확인
  Future<Map<String, dynamic>> pw_CheckCode_info(NewPw_checkCode_Info newPw_checkCode_info) async {
    Map<String ,dynamic> PWCheckCode_info = newPw_checkCode_info.toJson();
    PWCheckCode_info.putIfAbsent("token", () => newPwSendCodeToken);

    if(newPwSendCodeToken == null) {
      throw CodeNotSentException("인증번호 전송 버튼을 눌러주세요.");
    }

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json"
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + Check_Code_PW);
      result = await http.post(
          url, body: json.encode(PWCheckCode_info), headers: header);

      print("newPW_checkCode : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(result.body);
        newPwCheckCodeToken = res["token"];
        return res;
      } else if(result.statusCode == 400) {
        return{};
      }
      else if(result.statusCode == 401) {
        throw IncorrectCodeException("유효하지 않은 인증번호 입니다. 다시 입력해주세요.");
      } else {
        return {};
      }
    } catch(e) {
      return {};
    }
  }


  // 비번재설정 완료
  Future<Map<String, dynamic>> newPw_info(NewPw_Info newPw_info) async {
    Map<String ,dynamic> pw_info = newPw_info.toJson();
    pw_info.putIfAbsent("token", () => newPwCheckCodeToken);

    if(newPwCheckCodeToken == null) {
      throw CodeNotCheckException("인증번호 확인 버튼을 눌러주세요.");
    }

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json"
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + Set_PW);
      result = await http.put(
          url, body: json.encode(pw_info), headers: header);

      print("newPw_set : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(result.body);
        return res;
      } else if(result.statusCode == 400) {
        throw PWUnformatException("유효하지 않은 비밀번호 입니다. 다시 확인해주세요.");
      }
      else if(result.statusCode == 401) {
        throw IncorrectCodeException("유효하지 않은 인증번호 입니다. 다시 확인해주세요.");
      } else {
        return {};
      }
    } catch(e) {
      return {};
    }
  }



  // 유저 정보 설정
  Future<bool> set_info(My_Info my_info) async {

     String accessToken = (await TokenRefresher.getAccessToken())!;


    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + User_Info);
      var request = http.MultipartRequest('PUT', url);
      //result = await http.put(url, body: json.encode(setinfo), headers: header);

      request.fields.addAll({
        'region': my_info.region,
        'nickname': my_info.nickname,
      });
      request.files.add(await http.MultipartFile.fromPath('picture', my_info.picture));
      request.headers.addAll(header);

      http.StreamedResponse result = await request.send();

      print("myInfo_set : ");
      //print(result.body);

      if(result.statusCode == 200) {
        return true; // 성공
      } else {
        return false;  // 실패
      }
    } catch(e) {
      print(e);
    }

    return false;
  }


  // 마이페이지 조회
  Future<MyInfo> myInfoView() async
  {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type":"application/json",
      "Authorization" : accessToken
    };


    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + User_Info);
      print("url:" + url.toString());
      result = await http.get(url,  headers: header);

      print("response:");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));


        return MyInfo.fromJson(res);
      }
    }
    catch(e) {
      print(e);
    }

    throw SetMyInfoDataFailedException("마이페이지 정보 조회를 실패하였습니다.");
  }



}



