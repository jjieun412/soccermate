import 'dart:convert';

import 'package:soccermate/data/attendanceCheck/write_attendCheck_data.dart';
import 'package:soccermate/data/groupInfoCheck_data.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/groupList.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/soccerGroup.dart';
import 'package:soccermate/data/user_dto.dart';
import 'package:soccermate/exception/UnknownException.dart';
import 'package:soccermate/repository/global_static_variable.dart';
import 'package:soccermate/repository/util/TokenRefresher.dart';

import '../data/makeGroup_data.dart';
import 'package:http/http.dart' as http;




class Group_Repository {

  // 모임 생성
  static const MakeGroup = "/soccer-group";

  // 내가 속한 모임 조회
  static const MyGroup = "/get-my-soccer-group";



  // 모임 검색, 추천
  static const SearchGroup = "/soccer-group/search";
  static const RecommendGroup = "/soccer-group";

  // 모임 상세조회 (host)
  static const DetailGroup = "/soccer-group";
  static const User_Info = "/user";




  static final Group_Repository _totalRepository = Group_Repository._privTotalRepository();
  factory Group_Repository(){
    return _totalRepository;
  }

  Group_Repository._privTotalRepository(){

  }



  // 모임 생성 글
  Future<bool> groupMake_info(Group_Info group_info) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;


    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + MakeGroup);
      var request = http.MultipartRequest('POST', url);


      request.fields.addAll({
        'name': group_info.name,
        'description': group_info.description,
      });
      request.files.add(await http.MultipartFile.fromPath('picture', group_info.picture));
      request.headers.addAll(header);

      http.StreamedResponse result = await request.send();


      if(result.statusCode == 201) {
        return true; // 성공
      } else {
        return false;  // 실패
      }
    } catch(e) {
      print(e);
    }

    return false;
  }


  // 내가 속한 모임 (홈 하단바 젤 왼쪽)
  Future<GroupList_Info> myGroup_info() async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + RecommendGroup + "?size=50&page=0");
      result = await http.get(url, headers: header);

      print("recommend_group : ");
      //print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return GroupList_Info.fromJson(res);
      }
    } catch(e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }





  // 모임 검색
  Future<GroupList_Info> groupSearch_info(String keyword) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    Map<String, dynamic> bodyToSend = {"keyword": keyword};

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + SearchGroup + "?size=50&page=0");
      result = await http.post(
          url, body: json.encode(bodyToSend), headers: header);

      print("search_group : ");
      //print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return GroupList_Info.fromJson(res);
      }
    } catch(e) {
      print(e);
    }

    throw UnknownException("unknown exception!");

  }


  // 모임 추천
  Future<GroupList_Info> groupRecommend_info() async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + RecommendGroup + "?size=50&page=0");
      result = await http.get(url, headers: header);

      print("recommend_group : ");
      //print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return GroupList_Info.fromJson(res);
      }
    } catch(e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }



  // 모임 상세조회
  Future<SoccerGroup> groupDetail_info(int groupId) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup  + "/" + groupId.toString());
      result = await http.get(url, headers: header);

      print("detail_group : ");
      //print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return SoccerGroup.fromJson(res);
      }
    } catch(e) {
      print(e);
      throw e;

    }
    throw UnknownException("unknown exception!");
  }


  // 모임 상세조회 내 인원 프로필
  Future<GroupInfo_Check> groupUserDetail_info(int userId) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;


    late http.Response result;
    Map<String, String> header = {
      "Content-type" : "application/json",
      "Authorization" : accessToken
    };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + User_Info  + "/" + userId.toString());
      result = await http.get(url, headers: header);

      print("detail_group_user_info : ");
      print(result.body);

      if(result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        return GroupInfo_Check.fromJson(res);
      }
    } catch(e) {
      print(e);
      throw e;

    }
    throw UnknownException("unknown exception!");
  }

  Future<List<GroupInfo_Check>> getUserDetailsInGroup(List<int> users)
  {
    List<Future<GroupInfo_Check>> groupInfoCheckFuture = [];

    for(int user in users) {
      groupInfoCheckFuture.add(groupUserDetail_info(user));
    }

    return Future.wait(groupInfoCheckFuture);
  }


}




















