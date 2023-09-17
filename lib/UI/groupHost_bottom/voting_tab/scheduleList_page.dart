import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soccermate/UI/groupHost_bottom/attendance_page.dart';
import 'package:soccermate/UI/groupHost_bottom/voting_tab/detailVotingAttendance_page.dart';
import 'package:soccermate/data/attendanceCheck/AttendCheck.dart';
import 'package:soccermate/data/attendanceCheck/attendList.dart';
import 'package:soccermate/data/attendanceCheck/detail_attendCheck_data.dart';

import '../../../controller/user_controller.dart';





class ScheduleListPage extends StatefulWidget {
  late int groupId;
  ScheduleListPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/schedulelistpage";


  @override
  _ScheduleListPageState createState() => _ScheduleListPageState();
}



class _ScheduleListPageState extends State<ScheduleListPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  String _month = "2022. 11";
  Color inperoid = Color(0xFF3620FF);   // 파랑
  Color outperoid = Color(0xFF707070);  // 회색


  @override
  void initState() {
    _user_controller = User_Controller();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  Widget _slistRow(String date, String title, String schedule, String location, String kind) {
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
                      SizedBox(height: 15),
                      Text('${date.split("-")[2]}일', style: TextStyle(color: inperoid, fontSize: 20, fontFamily: "netmarbleB")),  // 8 일
                      //Text(day, style: TextStyle(color: Colors.black, fontSize: 11, fontFamily: "netmarbleM")),   // 토요일
                      SizedBox(height: 15),
                    ]
                ),

                SizedBox(width: 30),

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget> [
                      SizedBox(height: 5),
                      Text(title, style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: "netmarbleB")),    // 투표제목
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.calendar_month, size: 13),
                          SizedBox(width: 10),
                          Text(schedule, style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: "netmarbleM")),  // 모일 시간, 날짜
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on, size: 13),
                          SizedBox(width: 10),
                          Text(location, style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: "netmarbleM")),   // 모임 장소
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.sports_soccer, size: 13),
                          SizedBox(width: 10),
                          Text(kind, style: TextStyle(color: Colors.black, fontSize: 10, fontFamily: "netmarbleM")),   // 축구 or 풋살
                        ],
                      ),
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
                  child: FutureBuilder<AttendList_Info>(
                      future: _user_controller.attendList(groupId: widget.groupId),
                      builder: (BuildContext context, AsyncSnapshot<AttendList_Info> snapshot) {
                        if (snapshot.hasData) {
                          print("snapshot has AttendCheck_list data!");
                          List<AttendCheck> getList = snapshot.data!.attend_list;
                          print(getList.length);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text(
                                  '$_month',   // created time 에서 month 끌고와야함
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleM"
                                  )
                                ),
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
                                              //Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => AttendancePage(groupId: widget.groupId, meetingId: getList[index].meeting_id)));
                                              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => DetailVotingAttendancePage(groupId: widget.groupId, meetingId: getList[index].meeting_id)));
                                            },
                                            child: Container(
                                              width: screenWidth,
                                              child: _slistRow(getList[index].meeting_date, getList[index].meeting_name, getList[index].meeting_date +"  " +
                                                      getList[index].meeting_time, getList[index].meeting_location, getList[index].meeting_category),

                                              )
                                            );
                                    },
                                  )
                                ),
                              )
                            ]
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

                                    Text('예정된 일정이 없습니다.', style: TextStyle(color: Color(0xFF707070), fontSize: 18, fontFamily: "netmarbleB")),
                                  ]
                              ),
                            )
                        );
                      }
                    ),
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