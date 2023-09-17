import 'package:soccermate/data/attendanceCheck/AttendCheck.dart';
import 'package:soccermate/data/attendanceCheck/detail_attendCheck_data.dart';
import 'package:soccermate/data/attendanceCheck/write_attendCheck_data.dart';
import 'package:soccermate/data/certifyAttendance_data.dart';
import 'package:soccermate/data/groupInfoCheck_data.dart';
import 'package:soccermate/data/login_data.dart';
import 'package:soccermate/data/posting/PostingDetail.dart';
import 'package:soccermate/data/posting/write_posting_data.dart';
import 'package:soccermate/data/signup_checkcode_data.dart';
import 'package:soccermate/data/signup_sendcode_data.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/soccerGroup.dart';
import 'package:soccermate/data/user_dto.dart';
import 'package:soccermate/data/voting/CreateVotingDto.dart';
import 'package:soccermate/data/voting/DoVotingDto.dart';
import 'package:soccermate/data/voting/VotingItemsDetail.dart';
import 'package:soccermate/data/voting/doVoting_data.dart';
import 'package:soccermate/data/voting/write_voting_data.dart';
import 'package:soccermate/repository/group_repository.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../data/CreateMeeting/CreateMeetingDto.dart';
import '../data/attendanceCheck/AttendCheckDetail.dart';
import '../data/attendanceCheck/attendList.dart';
import '../data/login_data.dart';
import '../data/makeGroup_data.dart';
import '../data/myInfo_data.dart';
import '../data/newpw_checkcode_data.dart';
import '../data/newpw_data.dart';
import '../data/newpw_sendcode_data.dart';
import '../data/posting/CreatePostingDto.dart';
import '../data/posting/postingList.dart';
import '../data/setMyInfo_data.dart';
import '../data/signup_data.dart';
import '../data/soccerGroupSearchDtos/groupList.dart';
import '../data/voting/votingItemsList.dart';
import '../repository/groupCheck_repository.dart';



class User_Controller {
  late User_Repository userRepository;
  late Group_Repository groupRepository;
  late GroupCheck_Repository groupCheckRepository;

  static final User_Controller _userController = User_Controller._privUserController();
  factory User_Controller()
  {
    return _userController;
  }

  User_Controller._privUserController(){
    userRepository = User_Repository();
    groupRepository = Group_Repository();
    groupCheckRepository = GroupCheck_Repository();
  }



  // 로그인
  Future<int> login({required String email, required String password}) async {
    Login_Info login_info = Login_Info(email: email, password: password);

    user_dto udto = await userRepository.login_info(login_info);

    if(udto.role == user_dto.USER) {
      return 0;
    } else {
      return 1;
    }

  }


  // 회원가입
  Future<void> signup_send({required String email}) async {
    Signup_sendCode_Info signup_sendCode_info = Signup_sendCode_Info(email: email);

    await userRepository.signup_SendCode_info(signup_sendCode_info);
    return;
  }

  Future<void> signup_check({required String email, required String code}) async {
    Signup_checkCode_Info signup_checkCode_info = Signup_checkCode_Info(email: email, code: code);

    await userRepository.signup_CheckCode_info(signup_checkCode_info);
    return;
  }

  Future<void> signup({required String email, required String password}) async {
    Signup_Info signup_info = Signup_Info(email: email, password: password);

    await userRepository.signup_info(signup_info);
    return;
  }


// 비번 재설정
  Future<void> newPw_send({required String email}) async {
    NewPw_sendCode_Info newPw_sendCode_info = NewPw_sendCode_Info(email: email);
    await userRepository.pw_SendCode_info(newPw_sendCode_info);
    return;
  }

  Future<void> newPw_check({required String email, required String code}) async {
    NewPw_checkCode_Info newPw_checkCode_info = NewPw_checkCode_Info(email: email, code: code);
    await userRepository.pw_CheckCode_info(newPw_checkCode_info);
    return;
  }

  Future<void> newPw({required String email, required String password}) async {
    NewPw_Info newPw_info = NewPw_Info(email: email, password: password);
    await userRepository.newPw_info(newPw_info);
    return;
  }


  // 유저정보설정
  Future<bool> setInfo({required String nickname, required String region, required String picture}) async {
    My_Info my_info = My_Info(nickname: nickname, region: region, picture: picture);
    return userRepository.set_info(my_info);
  }


  // 마이페이지 조회
  Future<MyInfo> myInfo() async {
    return userRepository.myInfoView();
  }


  // 모임생성글
  Future<bool> groupInfo({required String name, required String description, required String picture}) async {
    Group_Info group_info = Group_Info(name: name, description: description, picture: picture);

    return groupRepository.groupMake_info(group_info);
  }


  //  모임 검색
  Future<GroupList_Info> searchGroup({required String keyword}) async {
    return groupRepository.groupSearch_info(keyword);
  }


  // 모임 추천
  Future<GroupList_Info> recommendGroup() async {
    return groupRepository.groupRecommend_info();
  }


  // 모임 상세조회
  Future<SoccerGroup> detailGroup({required int groupId}) async{
    SoccerGroup soccerGroup = await groupRepository.groupDetail_info(groupId);
    bool result = soccerGroup.members.remove(int.parse(soccerGroup.owner_id));
    print(soccerGroup.members);
    print(result);

    return soccerGroup;
  }

  // 모임 상세조회 내 인원 프로필 조회
  Future<List<GroupInfo_Check>> detailGroupUser({required List<int> userId}) async{
    return groupRepository.getUserDetailsInGroup(userId);
  }



  // 모임 참석게시글 작성 (방장)
  Future<Write_AttendCheck_Info> writeAttendCheck({required int groupId, required CreateMeetingDto createMeetingDto}) async {
    return groupCheckRepository.writeAttendCheck_info(groupId: groupId, createMeetingDto: createMeetingDto);
  }

  // 모임 참석게시글 조회 (목록 list 형태)
  Future<AttendList_Info> attendList({required int groupId}) async {
    return groupCheckRepository.attendList_info(groupId: groupId);
  }

  // 모임 참석게시글 상세조회 (참석여부 게시글 조회)
  Future<AttendCheckDetail> detailAttendCheck({required int groupId, required int meetingId}) async {
    return groupCheckRepository.detailAttendCheck_info(groupId: groupId, meetingId: meetingId);
  }

  // 모임 참석게시글 상세조회 (참석여부 O)
  Future<bool> attendYES({required int groupId, required int meetingId}) async {
    return groupCheckRepository.attendCheck_YES(groupId: groupId, meetingId: meetingId);
  }

  // 모임 참석게시글 상세조회 (참석여부 X)
  Future<bool> attendNO({required int groupId, required int meetingId}) async {
    return groupCheckRepository.attendCheck_NO(groupId: groupId, meetingId: meetingId);
  }

  // 모임 출석 위치 인증
  Future<bool> certifyAttendance({required int groupId, required int meetingId, required CertifyAttend_Info certifyAttend_Info}) async {
    return groupCheckRepository.certifyAttendance_info(groupId: groupId, meetingId: meetingId, certifyAttend_Info: certifyAttend_Info);
  }






  // 모임 투표게시글 작성 (방장)
  Future<Write_Voting_Info> writeVoting({required int groupId, required CreateVotingDto createVotingDto}) async {
    return groupCheckRepository.writeVoting_info(groupId: groupId, createVotingDto: createVotingDto);
  }

  // 모임 투표게시글 목록 조회 (투표목록)
  Future<VotingItemsList_Info> votingList({required int groupId}) async {
    return groupCheckRepository.votingList_info(groupId: groupId);
  }

  // 모임 투표게시글 상세조회 (투표 진행할 게시글)
  Future<VotingItemsDetail> detailVotingItems({required int groupId, required int voteId}) async {
    print("user_controller get detail voting items");
    return groupCheckRepository.detailVotingItems_info(groupId: groupId, voteId: voteId);
  }

  // 모임 투표게시글 투표하기
  Future<DoVoting_Info> doVoting({required int groupId, required int voteId, required DoVotingDto doVotingDto}) async {
    return groupCheckRepository.doVoting_info(groupId: groupId, voteId: voteId, doVotingDto: doVotingDto);
  }






  // 모임 공지게시글 작성 (방장)
  Future<Write_Posting_Info> writePosting({required int groupId, required CreatePostingDto createPostingDto}) async {
    return groupCheckRepository.writePosting_info(groupId: groupId, createPostingDto: createPostingDto);
  }

  // 모임 공지게시글 목록 조회
  Future<PostList_Info> postList({required int groupId}) async {
    return groupCheckRepository.postList_info(groupId: groupId);
  }

  // 모임 공지게시글 상세조회
  Future<PostingDetail> detailPosting({required int groupId, required int announcementId}) async {
    return groupCheckRepository.detailPosting_info(groupId: groupId, announcementId: announcementId);
  }

}