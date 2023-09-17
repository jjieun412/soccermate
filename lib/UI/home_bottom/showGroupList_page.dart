import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccermate/UI/groupHost_page.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/groupList.dart';
import 'package:soccermate/repository/util/TokenRefresher.dart';

import '../../controller/user_controller.dart';
import '../../data/soccerGroupSearchDtos/soccerGroup.dart';
import '../groupUser_page.dart';
import '../myInfo_page.dart';



class ShowGroupListPage extends StatefulWidget {
  const ShowGroupListPage({Key? key}) : super(key: key);

  static const route = "/showgrouplistpage";

  @override
  _ShowGroupListPageState createState() => _ShowGroupListPageState();
}


class _ShowGroupListPageState extends State<ShowGroupListPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  late TextEditingController _searchcontroller;



  @override
  void initState() {
    _user_controller = User_Controller();
    _searchcontroller = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 0.48;
    final double WidgetHeight = screenHeight * 0.18;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE7E7E7),

        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 15),
                  Image.asset('images/main_logo.png', scale: 7),
                  const SizedBox(width: 15),
                  const Text('soccer mate', style: TextStyle(fontSize: 17, fontFamily: "netmarbleB")),
                  const SizedBox(width: 100),
                  //마이페이지로 이동
                  IconButton(onPressed: () => {Navigator.pushNamed(context, MyInfoPage.route )}, icon: const Icon(Icons.person_pin, size: 40, color: Color(0xFFBCBCBC))),
                ],
              ),

              SizedBox(height: 10),

              // 검색바  --> keyword 입력 후 검색 시 일치하는 모임제목 검색해줌
              Container(
                  width: screenWidth * 0.8,
                  height: 50,
                  child: TextFormField(
                    controller: _searchcontroller,
                    cursorColor: Colors.green,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontFamily: "netmarbleB",
                    ),
                    decoration: InputDecoration(
                      fillColor: Color(0xFFF5F5F5),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.search, color: Color(0xFF707070)),
                        width: 18,
                      ),
                    ),
                  )
              ),

              SizedBox(height: 20),

              // gridVIew GroupView
              Container(
                width: screenWidth,
                height: screenHeight * 0.6,
                color: Color(0xFFF5F5F5),
                child: FutureBuilder<GroupList_Info>(
                    future:_user_controller.recommendGroup(),
                    builder: (BuildContext context, AsyncSnapshot<GroupList_Info> snapshot) {
                      if(snapshot.hasData){
                        print("snapshot has soccerGroup_List data!");
                        List<SoccerGroup> groupList_Info = snapshot.data!.soccer_group_list;

                        return GridView.count(
                          crossAxisCount: 2,
                          children: List.generate(groupList_Info.length, (index) {
                            return Container(
                                height: screenHeight * 0.28,
                                width: screenWidth * 0.48,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () async {
                                          // 로그인 시 받아온 나의 고유 Id
                                          int userId = await TokenRefresher.getUserId();
                                          String ownerId = await groupList_Info[index].owner_id;

                                          if(userId == int.parse(ownerId)) {
                                            // group모집글의 owner_id와 userId가 동일한 경우 Host 권한 가지는 페이지로 이동
                                            //Navigator.pushNamed(context, GroupHostPage.route);
                                            //Navigator.push(context, MaterialPageRoute(builder: (context) =>GroupHostPage(groupId: int.parse(groupSearch_Info[index].group_id))));
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => GroupHostPage(groupId: int.parse(groupList_Info[index].group_id) )));
                                          }

                                          for(int i=0; i<groupList_Info.length; i++) {
                                            if (userId == groupList_Info[i].members) {
                                              // group모집글의 member_id와 userId 비교하여 존재한다면 host 페이지로 이동 -> 게시글 권한 && 가입승인 막아야함
                                              Navigator.pushNamed(context, GroupHostPage.route);
                                            } else {
                                              // group모집글의 member_id와 userId 비교하여 존재하지 않는다면 가입페이지로 가야함
                                              Navigator.pushNamed(context, GroupUserPage.route);
                                            }
                                          }

                                        },

                                        child: Container(
                                          height: screenHeight * 0.19,
                                          width: screenWidth * 0.48,
                                          child: Image.network(groupList_Info[index].group_profile_pict_path, fit: BoxFit.fill),
                                        )
                                    ),
                                    Flexible(flex:1, child: Container()),
                                    Flexible(
                                        flex:5,
                                        child: text1Row(groupList_Info[index].group_name, groupList_Info[index].group_members_count)),
                                  ],
                                )
                            );
                          }),
                        );
                      }
                      else if(snapshot.hasError){
                        print(snapshot.error);
                        return Center(child: CircularProgressIndicator());}
                      else{
                        print("snapshot does not have data yet!");
                        return Center(child: CircularProgressIndicator());}
                    }
                )),
            ]
          )
        ),
      ),
    );
  }




  Flexible text1Row(String title, String count) {
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          const SizedBox(width: 30),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 120),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: "netmarbleB",
              ),
            ),
          ),
          const Icon(Icons.person,size: 20,color: Colors.black),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 15),
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: "netmarbleM",
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }


}




