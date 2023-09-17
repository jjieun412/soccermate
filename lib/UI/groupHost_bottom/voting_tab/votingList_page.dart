import 'package:flutter/material.dart';
import 'package:soccermate/UI/groupHost_bottom/voting_tab/detailOnGoingVoting_page.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/data/voting/VotingItems.dart';
import 'package:soccermate/data/voting/votingItemsList.dart';





class VotingListPage extends StatefulWidget {
  late int groupId;
  VotingListPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/votinglistpage";


  @override
  _VotingListPageState createState() => _VotingListPageState();
}



class _VotingListPageState extends State<VotingListPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  String _month = "2022. 12";
  Color inperoid = Color(0xFF3620FF);
  Color outperoid = Color(0xFF707070);


  @override
  void initState() {
    _user_controller = User_Controller();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _vlistRow(String date, String title) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text('${date.substring(8,10)}일', style: TextStyle(color: inperoid, fontSize: 20, fontFamily: "netmarbleB")),  // 8 일
                //Text(day, style: TextStyle(color: Colors.black, fontSize: 11, fontFamily: "netmarbleM")),   // 토요일
              ]
          ),

          SizedBox(width: 50),

          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Text(title, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "netmarbleB")),    // 투표제목
              ]
          ),
        ],
      ),
    );
  }




  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;


    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
              child: Container(
                  height: WidgetHeight,
                  width: WidgetWidth,
                  color: Color(0xFFE9E9E9),
                  child: FutureBuilder<VotingItemsList_Info>(
                      future: _user_controller.votingList(groupId: widget.groupId),
                      builder: (BuildContext context, AsyncSnapshot<VotingItemsList_Info> snapshot) {
                        if (snapshot.hasData) {
                          print("snapshot has VotingItems_list data!");
                          List<VotingItems> getList = snapshot.data!.votingItem_list;
                          print(getList.length);

                          return  Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  '$_month',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleM"
                                )),
                              ),


                              Expanded(
                                child: Container(
                                  width: WidgetWidth,
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
                                            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => DetailOnGoingVotingPage(groupId: widget.groupId, voteId: getList[index].vote_id)));
                                          },
                                          child: Container(
                                            width: screenWidth,
                                            height: 80,
                                            child: _vlistRow(getList[index].created_time, getList[index].title),   // created Date 형식확인
                                          )
                                      );
                                    },
                                  )
                              )

                              )]
                          );
                        }

                        return SafeArea(
                            child: Container(
                              height: WidgetHeight,
                              width: WidgetWidth,
                              color: Color(0xFFE9E9E9),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [

                                    Text('진행 중인 투표가 없습니다.', style: TextStyle(color: Color(0xFF707070), fontSize: 18, fontFamily: "netmarbleB")),
                                  ]
                              ),
                            )
                        );

                      })
                )
            ),
          )
        );
  }



  Widget spacer(int flex) {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }
}