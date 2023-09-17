import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccermate/data/groupInfoCheck_data.dart';
import 'package:soccermate/data/posting/Posting.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../../controller/user_controller.dart';
import '../../data/posting/postingList.dart';
import '../../data/soccerGroupSearchDtos/groupList.dart';
import '../../data/soccerGroupSearchDtos/soccerGroup.dart';
import 'detailPost_page.dart';



class HostBasicPage extends StatefulWidget {

  late int groupId;
  HostBasicPage({required int groupId ,Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/hostbasicpage";

  @override
  _HostBasicPageState createState() => _HostBasicPageState();
}


class _HostBasicPageState extends State<HostBasicPage> {
  final formKey = GlobalKey<FormState>();
  late final double maxImageWidth;
  late final double maxImageHeight;
  Color color = Colors.green;
  late User_Controller _user_controller;


  @override
  void initState() {
    _user_controller = User_Controller();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _buildRow(String imageAsset, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget> [
          SizedBox(height: 12),
          Row(
            children: <Widget> [
              CircleAvatar(backgroundImage: AssetImage(imageAsset)),
              SizedBox(width: 12),
              Text(name),
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }


  // 공지글 목록 조회
  Widget _PostRow(String title, String time) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              //Icon(Icons.surround_sound, size: 25, color: Colors.black),
              Image.asset('images/postalarm.png', scale: 4),
              SizedBox(width: 14),
              SizedBox(width: 100, child: Text(title, style: TextStyle(fontSize: 15, fontFamily: "netmarbleB"))),
              SizedBox(width: 100),
              Text('${time.substring(0,4)}. ${time.substring(5,7)}. ${time.substring(8,10)}', style: TextStyle(fontSize: 12, fontFamily: "netmarbleM", color: Colors.black)),
            ],
          ),
      );
  }


  // 모임 가입 요청 유저 승인 거절 Row -> host에게만 보여져야 함
  Widget _addRow(String imageAsset, String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget> [
          SizedBox(height: 12),
          Row(
            children: <Widget> [
              CircleAvatar(backgroundImage: AssetImage(imageAsset)),
              SizedBox(width: 12),
              Text(name),
              SizedBox(width: 12),

              // 승인
              OutlinedButton(
                onPressed: () async {

                },
                child: const Text('승인', style: TextStyle(color: Colors.green, fontSize: 10, fontFamily: "netmarbleB"),),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.green),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                ),
              ),

              // 거절
              OutlinedButton(
                onPressed: () async {

                },
                child: const Text('거절', style: TextStyle(color: Colors.red, fontSize: 10, fontFamily: "netmarbleB"),),
                style: OutlinedButton.styleFrom(
                    side: BorderSide(width: 1, color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                ),
              )
            ],
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFFE7E7E7),
          resizeToAvoidBottomInset: false,

          body: FutureBuilder<SoccerGroup>(
            future:_user_controller.detailGroup(groupId: widget.groupId),
            builder: (BuildContext context, AsyncSnapshot<SoccerGroup> snapshot) {
              if (snapshot.hasData) {
                print("snapshot has data!");
                SoccerGroup groupDetail_Info = snapshot.data!;

                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: WidgetsWidth,
                        height: 300,
                        child: Image.network(groupDetail_Info.group_profile_pict_path, fit: BoxFit.fill), // 모임 대표 이미지 보여주기
                      ),

                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.1,
                        color: Colors.white,
                        child: ContainerRow(groupDetail_Info.group_name, ((groupDetail_Info.members.length) + 1).toString(), groupDetail_Info.members, int.parse(groupDetail_Info.owner_id)),
                      ),

                      SizedBox(height: 10),

                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.14,
                        color: Colors.white,
                        child: ContentRow(groupDetail_Info.group_description)
                      ),

                      SizedBox(height: 10),

                      // 공지 게시글 조회 목록
                      Expanded(
                        child: Container(
                          width: WidgetsWidth,
                          color: Color(0xFFD3D3D3),
                          child: FutureBuilder<PostList_Info>(
                            future: _user_controller.postList(groupId: widget.groupId),
                            builder: (BuildContext context, AsyncSnapshot<PostList_Info> snapshot) {
                              if (snapshot.hasData) {
                                print("snapshot has Posting_list data!");
                                List<Posting> getList = snapshot.data!.post_list;
                                print(getList.length);

                                return Container(
                                  width: WidgetsWidth,
                                  height: screenHeight * 0.22,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: getList.length,
                                    separatorBuilder: (BuildContext context, int index) {
                                      return Container(height: 2, color: Color(0xFFE9E9E9)); },
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => DetailPostPage(groupId: widget.groupId, announceId: getList[index].announcement_id)));
                                        },
                                        child: Container(
                                          width: screenWidth,
                                          child: _PostRow(getList[index].announcement_title, getList[index].created_time),
                                        ),
                                      );
                                     },
                                  )
                                );
                              }
                              return Center(child: Text('공지 게시글이 없습니다.', style: TextStyle(color: Color(0xFF646464), fontSize: 14, fontFamily: "netmarbleB")));
                              }
                        )),
                      )
                  ]
                );
              }
              return Center(child: CircularProgressIndicator());
            })
      )

    );
  }


  List<Widget> getDialogRows(List<GroupInfo_Check> users) {
    List<Widget> listOfWidgetsToReturn = [];
    for(GroupInfo_Check user in users) {
        listOfWidgetsToReturn.add(_buildRow(user.profile, user.nickname));}
    return listOfWidgetsToReturn;
  }


  // 모임 제목과 오픈채팅방, 인원수표기
  Flexible ContainerRow(String title, String count, List<int> members, int ownerId) {
    List<int> members_copy = new List<int>.from(members);
    members_copy.add(ownerId);

    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(width: 30),

          Flexible(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacer(1),
                Text(title, style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: "netmarbleB")),
                spacer(1),
                Text('오픈채팅 링크', style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: "netmarbleB", decoration: TextDecoration.underline)),
                spacer(1),
              ],
            ),
          ),

          spacer(3),

          Flexible(
            flex: 4,
            child: FutureBuilder<List<GroupInfo_Check>>(
                future:_user_controller.detailGroupUser(userId: members_copy),
                builder: (BuildContext context, AsyncSnapshot<List<GroupInfo_Check>> snapshot) {
                  if (snapshot.hasData) {
                    print("snapshot has data!");
                    GroupInfo_Check ownerInfo = snapshot.data!.removeLast();
                    List<GroupInfo_Check> getUserDetailsInGroup = snapshot.data!;

                    return Badge(  // 가입 요청 발생시 알림표시 띄우기
                      position: BadgePosition.topStart(top: 5, start: -5),
                      badgeContent: const Icon(Icons.error_outline_sharp, size: 10, color: Colors.redAccent),
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                                  elevation: 16,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30),
                                      const Center(child: Text('방장', style: TextStyle(fontFamily: "netmarbleB"))),
                                      const SizedBox(height: 8),
                                      Container(height: 1, color: Colors.grey),
                                      // 그룹 방장 프로필
                                      _buildRow(ownerInfo.profile, ownerInfo.nickname),
                                      Container(height: 1, color: Colors.grey),


                                      Container(   // 모임 구성원 프로필 list
                                        child: ListView(
                                          shrinkWrap: true,
                                          children: [
                                        /*  가입요청한 유저
                            SizedBox(height: 40),
                            Center(child: Text('방장')),
                            SizedBox(height: 10),
                            Container(height: 2, color: Colors.grey),
                            _addRow('images/profile.png', '유저이름(닉네임)', 승인 요청, 거절 버튼),
                            Container(height: 2, color: Colors.grey),
                             */
                                            SizedBox(height: 70),
                                            Center(child: Text('모임 구성원', style: TextStyle(fontFamily: "netmarbleB"))),
                                            SizedBox(height: 12),
                                            Container(height: 1, color: Colors.grey),
                                            SizedBox(height: 15),

                                            for(GroupInfo_Check user in getUserDetailsInGroup) _buildRow(user.profile, user.nickname),

                                            SizedBox(height: 30),
                                          ],
                                        )
                                      ),
                                  ],
                              )
                            );
                          }
                      );
                    },
                    icon: Icon(Icons.person, size: 25, color: Color(0xFF3ABB3E)),
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2, color: Color(0xFF3ABB3E)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14))
                    ),
                    label: Text(count, style: TextStyle(color: Color(0xFF3ABB3E), fontSize: 16, fontFamily: "netmarbleB"),),
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            }),
          )
        ],
      ),
    );
  }


  Flexible ContentRow(String content) {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 30),
              Icon(Icons.wb_twilight, size: 20, color: Colors.black),
              Flexible(
                flex: 5,
                child: Text('  모임 소개', style: TextStyle(fontSize: 15, fontFamily: "netmarbleB")),
              ),
            ],
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 60),
              Flexible(
                flex: 5,
                child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: "netmarbleL",
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }


  Widget spacer(int flex){
    return Flexible(
        flex: flex,
        child: Container()
    );
  }
}

