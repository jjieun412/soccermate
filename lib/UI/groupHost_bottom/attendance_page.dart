import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:soccermate/UI/myInfo_page.dart';
import 'package:soccermate/data/attendanceCheck/AttendCheck.dart';
import 'package:soccermate/data/attendanceCheck/detail_attendCheck_data.dart';
import 'package:soccermate/data/certifyAttendance_data.dart';

import '../../controller/user_controller.dart';
import '../../data/attendanceCheck/AttendCheckDetail.dart';
import '../../data/myInfo_data.dart';




class AttendancePage extends StatefulWidget {

  late int groupId;
  late int meetingId;
  AttendancePage({required int groupId, required int meetingId, Key? key}) : super(key: key){
    this.groupId = groupId;
    this.meetingId = meetingId;
  }

  static const route = "/attendanceingpage";

  @override
  _AttendancePageState createState() => _AttendancePageState();
}


class _AttendancePageState extends State<AttendancePage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  Color backcolor = Colors.white;
  Color textcolor = Colors.grey;
  Color bordercolor = Colors.grey;
  bool _visibility = false;
  String attendanceText = '출석이 완료되었습니다.';

  late double lat = 0.0;
  late double lng = 0.0;
  late String _currentAddress = " ";


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
              '출석',
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
          future:_user_controller.detailAttendCheck(groupId: widget.groupId, meetingId: widget.meetingId),
          builder: (BuildContext context, AsyncSnapshot<AttendCheckDetail> snapshot) {
          if (snapshot.hasData) {
            print("snapshot has data!");
            AttendCheckDetail getInfo = snapshot.data!;

            return Container(
                height: WidgetHeight,
                width: WidgetsWidth,
                color: Color(0xFFE9E9E9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                SizedBox(width: 20),
                                Text(
                                  '모임 장소',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleB",
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              getInfo.meeting_location,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: "netmarbleL"),
                            ),
                          ]
                      ),
                    ),

                    SizedBox(height: 12),

                    //모임 날짜, 시간
                    Container(
                        padding: EdgeInsets.all(18),
                        width: WidgetsWidth,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '날짜: ${getInfo.meeting_date.month.toString()+"월 "+getInfo.meeting_date.day.toString() + "일 "}',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleM"),
                              ),

                              Text(
                                '시간: ${getInfo.meeting_time.hour.toString()+"시 "+getInfo.meeting_time.minute.toString() + "분 "}',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleM"),
                              ),

                              Text(
                                '종목: ${getInfo.meeting_category}',
                                style: TextStyle(color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "netmarbleM"),
                              ),
                            ]
                        )
                    ),

                    SizedBox(height: 12),

                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white),
                      child: FutureBuilder<MyInfo>(
                        future:_user_controller.myInfo(),
                        builder: (BuildContext context, AsyncSnapshot<MyInfo> snapshot) {
                          if (snapshot.hasData) {
                            print("snapshot has data!");
                            MyInfo getInfo = snapshot.data!;

                            return MyInfoRow(getInfo.profile, getInfo.nickname);
                        }
                          else{
                            return Center(child: CircularProgressIndicator());
                          }
                        }
                    )),

                    SizedBox(height: 30),

                    Visibility(
                      visible: _visibility,
                      child: Text('${attendanceText}', style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: "netmarbleM")),
                    )

                  ],
                )
            );
          }
            return Center(child: CircularProgressIndicator());
        }),
    );
  }


  Flexible MyInfoRow(String profile, String name) {
    return Flexible(
      flex: 2,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            SizedBox(width: 20),
            CircleAvatar(backgroundImage: AssetImage(profile)),
            SizedBox(width: 12),
            Text(name),
            SizedBox(width: 100),


            ElevatedButton(
                onPressed: () async {
                  // 출석 누르면 내 현 위치의 경도, 위도 받아서 서버로 전송
                  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  print(position);   // Latitude: ---, Longitude: ---
                  lat = position.latitude;
                  lng = position.longitude;
                  print('나 의 현 재 위 치 좌 표 값 받 아 오 기');
                  print(lat);
                  print(lng);

                  CertifyAttend_Info certifyAttend_info = CertifyAttend_Info(
                      x_coordinate: lat, y_coordinate: lng);

                 bool res = await _user_controller.certifyAttendance(groupId: widget.groupId, meetingId: widget.meetingId, certifyAttend_Info: certifyAttend_info);

                  if (res) {
                    backcolor = Colors.green;
                    textcolor = Colors.white;
                    bordercolor = Colors.green;
                    _visibility = true;
                  } else {
                    _visibility = true;
                    attendanceText = '출석 인증에 실패하였습니다.\n 설정한 모임장소로 더 가까이 이동해 주세요.';
                  }

                  setState(() {

                  });
                },
              style: ElevatedButton.styleFrom(
                primary: backcolor,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 2, color: bordercolor),
                )
              ),
              child: Text('출석',style: TextStyle(color: textcolor, fontFamily: "netmarbleB", fontSize: 15)),

            )
          ]
      ),
    );
  }





  Widget spacer(int flex) {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }


}