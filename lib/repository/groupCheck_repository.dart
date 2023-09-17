import 'dart:convert';

import 'package:soccermate/data/attendanceCheck/write_attendCheck_data.dart';
import 'package:soccermate/data/certifyAttendance_data.dart';
import 'package:soccermate/data/posting/CreatePostingDto.dart';
import 'package:soccermate/data/voting/CreateVotingDto.dart';
import 'package:soccermate/data/voting/VotingItemsDetail.dart';
import 'package:soccermate/data/voting/doVoting_data.dart';
import 'package:soccermate/data/voting/votingDate_op.dart';
import 'package:soccermate/data/voting/votingItemsList.dart';
import 'package:soccermate/data/voting/write_voting_data.dart';
import 'package:soccermate/exception/UnknownException.dart';
import 'package:soccermate/repository/global_static_variable.dart';
import 'package:soccermate/repository/util/TokenRefresher.dart';

import '../data/CreateMeeting/CreateMeetingDto.dart';
import '../data/attendanceCheck/AttendCheckDetail.dart';
import '../data/attendanceCheck/attendList.dart';
import 'package:http/http.dart' as http;

import '../data/posting/PostingDetail.dart';
import '../data/posting/postingList.dart';
import '../data/posting/write_posting_data.dart';
import '../data/voting/DoVotingDto.dart';





class GroupCheck_Repository {

  // 모임 상세조회 (host)
  static const DetailGroup = "/soccer-group";
  static const User_Info = "/user";

  // 참석 게시글 작성(only 방장) 및 조회, 인증
  static const Write_AttendCheck = "/meetings";
  static const Confirm_Attendcheck = "/attendance";
  static const GetMeetings_Attendcheck = "/get-my-meetings";

  // 장소에서 출석 인증
  static const Attendance = "/join";

  // 투표 게시글 작성(only 방장) 및 조회, 상세조회
  static const Write_Voting = "/votes";

  // 투표하기
  static const Do_Voting = "/vote-submission";

  // 공지 게시글 작성(only 방장) 및 조회, 상세조회
  static const Write_Post = "/announcements";




  static final GroupCheck_Repository _totalRepository = GroupCheck_Repository._privTotalRepository();

  factory GroupCheck_Repository() {
    return _totalRepository;
  }

  GroupCheck_Repository._privTotalRepository() {
  }




  // 모임 참석게시글 작성
  Future<Write_AttendCheck_Info> writeAttendCheck_info({required int groupId, required CreateMeetingDto createMeetingDto}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    print("body to send: " + json.encode(createMeetingDto.toJson()));
    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_AttendCheck + "?size=50&page=0");
      result = await http.post(url, body: json.encode(createMeetingDto.toJson()), headers: header);

      print("write_attendanceCheck : ");
      //print(result.body);

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return Write_AttendCheck_Info.fromJson(res);
      }
    } catch (e) {
      print(e);
    }

    throw UnknownException("unknown exception!");
  }



  // 모임 참석게시글 리스트조회 (일정목록)
  Future<AttendList_Info> attendList_info({required int groupId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_AttendCheck + "?size=50&page=0");
      result = await http.get(url, headers: header);

      print("attendCheck_Lists : ");
      //print(result.body);

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return AttendList_Info.fromJson(res);
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnknownException("unknown exception!");
  }


  // 모임 참석게시글 리스트 상세조회 (일정목록 -> 참석여부 게시물)
  Future<AttendCheckDetail> detailAttendCheck_info({required int groupId, required int meetingId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_AttendCheck + "/"+ meetingId.toString());
      result = await http.get(url, headers: header);

      print("detail_attendCheck : ");
      //print(result.body);

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print('res: ');
        print(res);
        return AttendCheckDetail.fromJson(res);
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnknownException("unknown exception!");
  }


  // 모임 참석게시글 리스트 상세조회에서 참석 여부 체크 (O)  -- post
  Future<bool> attendCheck_YES({required int groupId, required int meetingId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_AttendCheck + "/" + meetingId.toString() + Confirm_Attendcheck);
      result = await http.post(url, headers: header);

      print("getMeetings_attendYES : ");

      if (result.statusCode == 200) {
        print('getMeeting_success');
        return true;
      } else {
        print('getMeeting_failed');
        return false;
      }
    } catch (e) {
      print(e);
    }

    throw UnknownException("unknown exception!");
  }


  // 모임 참석게시글 리스트 상세조회에서 참석 여부 체크 (X) -> delete
  Future<bool> attendCheck_NO({required int groupId, required int meetingId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_AttendCheck + "/" + meetingId.toString() + Confirm_Attendcheck);
      result = await http.delete(url, headers: header);

      print("attendCheck_NO : ");

      if (result.statusCode == 200) {
        print('NO_success');
        return true;
      } else {
        print('NO_failed');
        return false;
      }
    } catch (e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }
/*

  // 모임 참석게시글 yes 한 meeting get하기
  Future<GetMeetings_YES> getMeetins_AttendYES({required int groupId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_AttendCheck + GetMeetings_Attendcheck);
      result = await http.post(url, headers: header);

      print("attendCheck_YES : ");
      //print(result.body);

      if (result.statusCode == 200) {
        print('YES_success');
        return true;
      } else {
        print('YES_failed');
        return false;
      }
    } catch (e) {
      print(e);
    }

    throw UnknownException("unknown exception!");
  }

 */




  // 모임 출석 위치 인증
  Future<bool> certifyAttendance_info({required int groupId, required int meetingId, required CertifyAttend_Info certifyAttend_Info}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
        groupId.toString() + Write_AttendCheck + "/" + meetingId.toString() + Attendance);
      result = await http.post(url, body: json.encode(certifyAttend_Info.toJson()), headers: header);

      print("certify_Attendance : ");

      if (result.statusCode == 200) {
        print('출석인증 좌표 전송 성공');
        return true;
      }
    } catch (e) {
      print(e);
    }

    print('출석인증 좌표 전송 실패');
    return false;

  }












  // 모임 투표게시글 작성
  Future<Write_Voting_Info> writeVoting_info({required int groupId, required CreateVotingDto createVotingDto}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_Voting);
      result = await http.post(url, body: json.encode(createVotingDto.toJson()), headers: header);

      print("write_Voting : ");
      print(result.statusCode);

      if (result.statusCode == 200) {
        print("write Voting success");
      } else {
        print("write Voting failed");
      }
    } catch (e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }


  // 모임 투표 리스트 조회 (투표목록)
  Future<VotingItemsList_Info> votingList_info({required int groupId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };


    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_Voting + "?size=50&page=0");
      result = await http.get(url, headers: header);

      print("VotingItemsList : ");

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return VotingItemsList_Info.fromJson(res);
      }
    } catch (e) {
      print(e);
    }

    throw UnknownException("unknown exception!");
  }



  // 모임 투표 리스트 상세조회 (유저가 투표할 수 있도록)
  Future<VotingItemsDetail> detailVotingItems_info({required int groupId, required int voteId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_Voting + "/"+ voteId.toString());
      result = await http.get(url, headers: header);

      print("detail_votingItems : ");

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);

        //List<detailDates> temp = (res["dates"] as List).map((dynamic e) => e as Map<String, dynamic>).cast<detailDates>().toList();
        //print(temp);
        return VotingItemsDetail.fromJson(res);
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnknownException("unknown exception!");
  }


  // 상세 조회 -> 투표 하기 (do Voting)
  Future<DoVoting_Info> doVoting_info({required int groupId, required int voteId, required DoVotingDto doVotingDto}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_Voting + "/" + voteId.toString() + Do_Voting);
      result = await http.post(url, body: json.encode(doVotingDto.toJson()), headers: header);

      print("do_voting/checking : ");

      if (result.statusCode == 200) {
        print("do voting success");
        //return true;   // 성공
      } else {
        print("do voting failed");
        //return false;  // 실패
      }
    } catch (e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }







  // 모임 공지게시글 작성
  Future<Write_Posting_Info> writePosting_info({required int groupId, required CreatePostingDto createPostingDto}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken };

    //print("body to send: " + json.encode(createPostingDto.toJson()));

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" + groupId.toString() + Write_Post);
      result = await http.post(url, body: json.encode(createPostingDto.toJson()), headers: header);

      print("write_posting : ");

      if (result.statusCode == 201) {
        print("write post success");
        //return true;   // 성공
      } else {
        print("write post failed");
        //return false;  // 실패
      }
    } catch (e) {
      print(e);
    }
    throw UnknownException("unknown exception!");
  }


  // 모임 공지게시글 리스트조회
  Future<PostList_Info> postList_info({required int groupId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_Post + "?size=50&page=0");
      result = await http.get(url, headers: header);

      print("posting_Lists : ");
      //print(result.body);

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print(res);
        return PostList_Info.fromJson(res);
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnknownException("unknown exception!");
  }


  // 모임 공지게시글 리스트 상세조회
  Future<PostingDetail> detailPosting_info({required int groupId, required int announcementId}) async {
    String accessToken = (await TokenRefresher.getAccessToken())!;

    late http.Response result;
    Map<String, String> header = {
      "Content-type": "application/json",
      "Authorization": accessToken};

    try {
      Uri url = Uri.parse(global_static_variable.BaseUrl + DetailGroup + "/" +
          groupId.toString() + Write_Post + "/"+ announcementId.toString());
      result = await http.get(url, headers: header);

      print("detail_Posting : ");
      //print(result.body);

      if (result.statusCode == 200) {
        Map<String, dynamic> res = json.decode(utf8.decode(result.bodyBytes));
        print('res: ');
        print(res);
        return PostingDetail.fromJson(res);
      }
    } catch (e) {
      print(e);
      throw e;
    }
    throw UnknownException("unknown exception!");
  }

}
