import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:soccermate/UI/groupHost_bottom/attendance_page.dart';
import 'package:soccermate/UI/groupHost_page.dart';

import '../../../controller/user_controller.dart';
import '../../../data/attendanceCheck/AttendCheckDetail.dart';
import '../../../data/groupInfoCheck_data.dart';



class DetailVotingAttendancePage extends StatefulWidget {
  late int groupId;
  late int meetingId;
  DetailVotingAttendancePage({required int groupId, required int meetingId, Key? key}) : super(key: key) {
    this.groupId = groupId;
    this.meetingId = meetingId;
  }
  static const route = "/detailvotingattendancepage";

  @override
  _DetailVotingAttendancePageState createState() => _DetailVotingAttendancePageState();
}


class _DetailVotingAttendancePageState extends State<DetailVotingAttendancePage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  Color _backColor = Colors.white;
  Color _textColor = Color(0xFF707070);
  Color _borderColor = Color(0xFF707070);
  String attendText = '참석 신청이 완료되었습니다.';
  bool _visibility = false;
  bool _visibility_btn = false;

  double lat = 0.0;
  double lng = 0.0;
  String groupRegion = "";


  // 내 위치 받아오기 (위도, 경도)
  void getLocation(double lat, double lng) async {
    final String GOOGLE_API_KEY = 'AIzaSyAllB79K-OXtdoaumBYwbCx7Db6eRK-3NE';
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY&language=ko';

    Response response = await http.get(Uri.parse(url));
    groupRegion = jsonDecode(response.body)['results'][0]['formatted_address'];
  }


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
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),
          CircleAvatar(backgroundImage: AssetImage(imageAsset)),
          SizedBox(height: 8),
          Text(name, style: TextStyle(fontFamily: "netmarbleM", fontSize: 10)),
          SizedBox(height: 10)
        ],
      ),
    );
  }


  void changeState() {
    setState(() {
      if(_backColor == Colors.white){  // 참석
        _backColor = Color(0xFF3ABB3E);
        _textColor = Colors.white;
        _borderColor = Color(0xFF3ABB3E);
        _visibility = true;
        _visibility_btn = true;
        attendText = '참석 신청이 완료되었습니다.';
        print('attendCheck_yes_complete');
      } else {  // 비참석
        _backColor = Colors.white;
        _textColor = Color(0xFF707070);
        _borderColor = Color(0xFF707070);
        _visibility = true;
        _visibility_btn = false;
        attendText = '참석 신청이 취소되었습니다.';
        print('attendCheck_no_complete');
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            '참석 투표',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: "netmarbleB"),
          ),
          leading: const BackButton(color: Colors.black),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(color: Color(0xFFE9E9E9), height: 12),
          ),
        ),
      ),

      body: FutureBuilder<AttendCheckDetail>(
          future: _user_controller.detailAttendCheck(groupId: widget.groupId, meetingId: widget.meetingId),
          builder: (BuildContext context, AsyncSnapshot<AttendCheckDetail> snapshot) {
            if(snapshot.hasData) {
              print("snapshot has detail AttendCheckDetail data");
              AttendCheckDetail getDetailAttend = snapshot.data!;
              lat = getDetailAttend.meeting_y_coordinate;
              lng = getDetailAttend.meeting_x_coordinate;


              return SafeArea(
                  child: Container(
                    height: WidgetHeight,
                    width: WidgetsWidth,
                    color: Color(0xFFE9E9E9),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: WidgetHeight * 0.1,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text(
                                '모임 장소',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: "netmarbleB",
                                ),
                              ),
                              SizedBox(width: 80),
                              Text(   // 모임 장소
                                '${getDetailAttend.meeting_location}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: "netmarbleL"),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 12),

                        //모임 날짜, 시간
                        Container(
                          padding: EdgeInsets.all(18),
                          width: WidgetsWidth,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const SizedBox(width: 20),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text( // 날짜:  10/1(토)  (예시)
                                        '날짜: ${getDetailAttend.meeting_date.month}월 ${getDetailAttend.meeting_date.day}일 ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: "netmarbleM")),
                                    Text(  //시간: pm 1:00   (예시)
                                        '시간: ${getDetailAttend.meeting_time.hour}시 ${getDetailAttend.meeting_time.minute}분',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: "netmarbleM")),
                                  ]
                              ),
                              const SizedBox(width: 60),

                              // 참석 버튼
                              ElevatedButton(
                                onPressed: () async {
                                  changeState();
                                  if(_backColor == Colors.white){
                                    print('참석 안할 경우');
                                    _user_controller.attendNO(groupId: widget.groupId, meetingId: widget.meetingId);
                                  } else {
                                    print('참석 성공 경우');
                                    _user_controller.attendYES(groupId: widget.groupId, meetingId: widget.meetingId);
                                  }},
                                style: ElevatedButton.styleFrom(
                                    primary: _backColor,
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10, bottom: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(width: 2, color: _borderColor),
                                    )),
                                child: Text('참석',
                                    style: TextStyle(
                                        color: _textColor,
                                        fontFamily: "netmarbleM",
                                        fontSize: 15)
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 50),

                        Visibility(
                          visible: _visibility,
                          child: Text('$attendText', style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "netmarbleM")),
                        ),

                        const SizedBox(height: 70),


                        // 출석 인증 버튼 btn
                        Visibility(
                          visible: _visibility_btn,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('해당 모임 날짜,시간에 모임 장소에 가서 \n    출석 인증을 해주세요.!!', style: TextStyle(
                                  color: Color(0xFF3ABB3E),
                                  fontSize: 14,
                                  fontFamily: "netmarbleB")),

                              ConstrainedBox(
                                constraints: const BoxConstraints.tightFor(width: 240),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (_) => AttendancePage(groupId: widget.groupId, meetingId: widget.meetingId)));
                                  },
                                  child: const Text('모임 출석 인증 하러 가기', style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "netmarbleB",
                                    fontSize: 14,
                                  )),
                                  style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    primary: Color(0xFF3ABB3E),
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                                ),
                              ),
                          )
                            ]
                          )

                        ),


/*
                      Container(
                          width:WidgetsWidth,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Text('<참석 인원 프로필>', style: TextStyle(color: Colors.black, fontSize: 13, fontFamily: "netmarbleB"),)
                      ),

                      Container(
                          width:WidgetsWidth,
                          height: WidgetHeight*0.5,
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(color: Colors.white),
                          child: pInfoRow((getDetailAttend.joined_members.length), getDetailAttend.joined_members, int.parse(source) )
                      ),
 */

                      ],
                    ),
                  ));
            }
            return Center(child: CircularProgressIndicator());
          }),

    );
  }



  Flexible CheckingRow(String date, String time) {
    return Flexible(
        flex: 2,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: 20),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text( // 날짜:  10/1(토)  (예시)
                        '날짜: ${date}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "netmarbleM")),
                    Text(  //시간: pm 1:00   (예시)
                        '시간: ${time}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "netmarbleM")),
                  ]
              ),

              spacer(1),

              // 참석 버튼
              ElevatedButton(
                onPressed: () async {
                  changeState();
                  if(_backColor == Colors.white){
                    print('참석 실패 경우');
                    _user_controller.attendNO(groupId: widget.groupId, meetingId: widget.meetingId);
                  } else {
                    print('참석 성공 경우');
                    _user_controller.attendYES(groupId: widget.groupId, meetingId: widget.meetingId);

                    Navigator.pushNamed(context, GroupHostPage.route, arguments: widget.meetingId);
                  }},
                style: ElevatedButton.styleFrom(
                    primary: _backColor,
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(width: 2, color: _borderColor),
                    )),
                child: Text('참석',
                    style: TextStyle(
                        color: _textColor,
                        fontFamily: "netmarbleM",
                        fontSize: 15)
                ),
              )
            ],
        )
    );
  }


  Widget pInfoRow(int count, List<int> members, int myId) {
    return Flexible(
        flex: 2,
        child: FutureBuilder<AttendCheckDetail>(
            future: _user_controller.detailAttendCheck(groupId: widget.groupId, meetingId: widget.meetingId),
            builder: (BuildContext context, AsyncSnapshot<AttendCheckDetail> snapshot) {
              if (snapshot.hasData) {
                print("snapshot has detail AttendCheck data");
                //AttendCheck getDetailAttend = snapshot.data!.joined_members as Detail_AttendCheck_Info;
                //List<GroupInfo_Check> getUserDetailsInGroup = snapshot.data!;

                return GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: List.generate(count, (index) {
                    return Container(
                      alignment: Alignment.center,
                      child: _buildRow('images/profile.png', '유저 이름(닉네임)'),
                    );
                  }),
                );
              }
              return const CircularProgressIndicator();
            })
    );
  }


  List<Widget> getDialogRows(List<GroupInfo_Check> users) {
    List<Widget> listOfWidgetsToReturn = [];

    for(GroupInfo_Check user in users) {
      listOfWidgetsToReturn.add(_buildRow(user.profile, user.nickname));
    }

    return listOfWidgetsToReturn;
  }




  Widget spacer(int flex) {
    return Flexible(flex: flex, child: Container());
  }

}
