import 'package:flutter/material.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/groupList.dart';

import '../../controller/user_controller.dart';
import '../../data/soccerGroupSearchDtos/soccerGroup.dart';
import '../../repository/util/TokenRefresher.dart';
import '../groupHost_page.dart';
import '../groupUser_page.dart';



class MyGroupListPage extends StatefulWidget {
  const MyGroupListPage({Key? key}) : super(key: key);

  @override
  _MyGroupListPageState createState() => _MyGroupListPageState();
}

class _MyGroupListPageState extends State<MyGroupListPage> {
  final formKey = GlobalKey<FormState>();

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


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 0.45;
    final double WidgetHeight = screenHeight * 0.15;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE7E7E7),

        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              '참여하고 있는 모임 목록',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "netmarbleB"
              ),
            ),
            leading: const BackButton(
              color: Colors.grey,
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: Colors.grey,
                height: 1,
              ),
            ),
          ),
        ),
/*
        body: FutureBuilder<GroupList_Info>(
            future:_user_controller.recommendGroup(),
            builder: (BuildContext context, AsyncSnapshot<GroupList_Info> snapshot){

              if(snapshot.hasData){
                print("snapshot has data!");
                List<SoccerGroup> groupList_Info = snapshot.data!.soccer_group_list;

                return GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(groupList_Info.length, (index) {
                    return Container(
                        height: screenHeight * 0.4,
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
                                  child: Image.network(groupList_Info[index].group_profile_pict_path, fit: BoxFit.fill,),
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
        ))
    );

 */
    ));
  }



  Flexible text1Row(String title, String count) {
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 110),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
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
                fontFamily: "netmarbleB",
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }


}
