import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soccermate/UI/groupHost_bottom/dateVoting_page.dart';
import 'package:soccermate/controller/user_controller.dart';

import '../../../../data/CreateMeeting/CreateMeetingDate.dart';
import '../../../../data/CreateMeeting/CreateMeetingDto.dart';
import '../../../../data/CreateMeeting/CreateMeetingTime.dart';





class WriteAttendPage extends StatefulWidget {
  late int groupId;
  WriteAttendPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/writeattendpage";

  @override
  _WriteAttendPageState createState() => _WriteAttendPageState();
}


class _WriteAttendPageState extends State<WriteAttendPage> {
  final formKey = GlobalKey<FormState>();
  //Completer<GoogleMapController> _mapController = Completer();
  late User_Controller _user_controller;
  late TextEditingController _titlecontroller;
  late TextEditingController _locationcontroller;

  late DateTime date = DateTime.now();
  String? time = '';
  String? location = '';
  
  TimeOfDay? timeOfDay;
  DateTime? dateTime;

  late double lat = 0.0;
  late double lng = 0.0;
  late String _inputAddress = "";
  late String _inputRegion = "";



  @override
  void initState() {
    _user_controller = User_Controller();
    _titlecontroller = TextEditingController(text: "");
    _locationcontroller = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _locationcontroller.dispose();
    super.dispose();
  }


  // 입력 주소의 위도, 경도 받아오기
  void _getCoordinate() async {
    _inputAddress = _locationcontroller.text;
    print(_inputAddress);

    final String GOOGLE_API_KEY = 'AIzaSyAllB79K-OXtdoaumBYwbCx7Db6eRK-3NE';
    final String LOCATION = _inputAddress;
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$LOCATION&key=$GOOGLE_API_KEY&language=ko';
    print(url);

    Response response = await http.get(Uri.parse(url));

    String region = jsonDecode(response.body)['results'][0]['formatted_address'];
    print(region);
    _inputRegion = region;

    double latitude = jsonDecode(response.body)['results'][0]['geometry']['location']['lat'];
    double longtitude = jsonDecode(response.body)['results'][0]['geometry']['location']['lng'];
    lat = latitude;
    lng = longtitude;
    print(lat);
    print(lng);
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
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                '참석 게시글',
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

          body: SafeArea(
              child: Container(
                  height: WidgetHeight,
                  width: WidgetWidth,
                  color: Color(0xFFE9E9E9),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget> [

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: TitleRow(),
                          ),

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: DateRow(),
                          ),

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: TimeRow(),
                          ),

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: LocationRow(),
                          ),


                          const SizedBox(height: 30),

                          // 참석 게시글 생성 버튼
                          ElevatedButton(
                            onPressed: () async {
                              if(timeOfDay == null || dateTime ==null) {
                                return;
                              }
                              _inputAddress = _locationcontroller.text;
                              print(_inputAddress);

                              final String GOOGLE_API_KEY = 'AIzaSyAllB79K-OXtdoaumBYwbCx7Db6eRK-3NE';
                              final String LOCATION = _inputAddress;
                              final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$LOCATION&key=$GOOGLE_API_KEY&language=ko';
                              print(url);

                              Response response = await http.get(Uri.parse(url));

                              String region = jsonDecode(response.body)['results'][0]['formatted_address'];
                              print(region);
                              _inputRegion = region;

                              double latitude = jsonDecode(response.body)['results'][0]['geometry']['location']['lat'];
                              double longtitude = jsonDecode(response.body)['results'][0]['geometry']['location']['lng'];
                              lat = latitude;
                              lng = longtitude;

                              print('-------------------------');
                              print("dateTime to send: " + dateTime.toString());
                              print("timeOfDay to send: " + timeOfDay.toString());
                              print(lat);
                              print(lng);
                              print('-------------------------');
                              
                              CreateMeetingTime createMeetingTime = CreateMeetingTime(hour: timeOfDay!.hour, minute: timeOfDay!.minute);
                              CreateMeetingDate createMeetingDate = CreateMeetingDate(year: dateTime!.year, month:dateTime!.month, day: dateTime!.day);
                              
                              CreateMeetingDto createMeetingDto = CreateMeetingDto(
                                  meeting_name: _titlecontroller.text, 
                                  meeting_date: createMeetingDate,
                                  meeting_x_coordinate: lat,
                                  meeting_y_coordinate: lng,
                                  //meeting_location: _locationcontroller.text + "\n( " + _inputRegion + " )",
                                  meeting_location: _locationcontroller.text,
                                  meeting_time: createMeetingTime,
                                  meeting_category: "축구");
                              
                              _user_controller.writeAttendCheck(groupId: widget.groupId, createMeetingDto: createMeetingDto);

                              Navigator.push(context, MaterialPageRoute(builder: (context) => DateVotingPage(groupId: widget.groupId)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
                            ),
                            child: const Text('참석 생성하기', style: TextStyle(
                              color: Colors.white,
                              fontFamily: "netmarbleB",
                              fontSize: 14,
                            )),
                          ),

                          const SizedBox(height: 50),

                        ]
                    ),
                  )
              )
          ),
        )
    );
  }



  Flexible TitleRow() {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            '참석 게시글 제목을 입력해주세요.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 220),
            child: TextFormField(
              controller: _titlecontroller,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '제목 입력',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible DateRow() {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            '모임을 진행할 날짜를 선택해주세요.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month, color: Color(0xFF3ABB3E), size: 30),
              label: Text('${date.year}. ${date.month}. ${date.day}', style: const TextStyle(color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );

                if(newDate == null) return;
                setState(() {
                  date = newDate;
                  dateTime = newDate;
                });
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
              ),
            ),
          ),

        ],
      ),
    );
  }


  Flexible TimeRow() {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            '모임을 진행할 시간을 설정해주세요.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.more_time, color: Color(0xFF3ABB3E), size: 30),
              label: Text('$time', style: const TextStyle(color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now());

                if(newTime != null) {
                  setState(() {
                    time = newTime.format(context);
                    timeOfDay = newTime;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  primary: Colors.white,
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
              ),
            ),
          ),

        ],
      ),
    );
  }


  Flexible LocationRow() {
    return Flexible(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Text(
            '모임을 진행할 장소를 입력해주세요.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 220),
            child: TextFormField(
              controller: _locationcontroller,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '장소 입력',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                  )
              ),
            ),
          ),

        ],
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
