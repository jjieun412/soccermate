import 'package:flutter/material.dart';
import 'package:soccermate/UI/groupHost_bottom/dateVoting_page.dart';
import 'package:soccermate/UI/groupHost_bottom/voting_tab/votingList_page.dart';
import 'package:soccermate/data/CreateMeeting/CreateMeetingTime.dart';
import 'package:soccermate/data/voting/CreateVotingDto.dart';
import '../../../../controller/user_controller.dart';
import '../../../data/CreateMeeting/CreateMeetingDate.dart';
import '../../../data/voting/write_voting_data.dart';




class WriteVotingPage extends StatefulWidget {
  late final int groupId;
  WriteVotingPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/writevotingpage";

  @override
  _WriteVotingPageState createState() => _WriteVotingPageState();
}



class _WriteVotingPageState extends State<WriteVotingPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;

  late TextEditingController _titlecontroller;
  late TextEditingController _locationcontroller;

  late DateTime date = DateTime.now();
  String time = '';


  int Dcount = 0, Tcount = 0, Lcount = 1;
  bool _isShow = false;


  //List<String> dates = [];
  //List<String> times = [];
  late List<CreateMeetingDate> dates = [];
  late List<CreateMeetingTime> times = [];
  late List<String> setLocation = [];
  late List<String> setCategory = ['축구', '풋살'];

  TimeOfDay? timeOfDay;
  DateTime? dateTime;

  late CreateMeetingDate createMeetingDate;
  late CreateMeetingTime createMeetingTime;




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


  Widget _dateBtn(String settingDate) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.calendar_month, color: Colors.green, size: 30),
        label: Text(settingDate,
            style: const TextStyle(
                color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
        onPressed: () async {},
        style: ElevatedButton.styleFrom(
            elevation: 5,
            primary: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))
        ),
      ),
    );
  }


  Widget _timeBtn(String settingTime) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.more_time, color: Colors.green, size: 30),
        label: Text(settingTime, style: const TextStyle(color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
        onPressed: () async {},
        style: ElevatedButton.styleFrom(
            elevation: 4,
            primary: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
        ),
      ),
    );
  }


  Widget _locationRow() {
    return Visibility(
        visible: _isShow,
        child: Container(
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
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                '투표 게시글',
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
                  color: Colors.white,
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
                            width: 240,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: Dcount,
                              itemBuilder: (BuildContext context, int index) {
                                //return _dateBtn(dates[index]);
                                return _dateBtn('${dates[index].year}. ${dates[index].month}. ${dates[index].day}');
                              },
                            ),
                          ),


                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: TimeRow(),
                          ),

                          Container(
                            width: 240,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: Tcount,
                              itemBuilder: (BuildContext context, int index) {
                                //return _timeBtn(times[index]);
                                return _timeBtn('${times[index].hour}시 ${times[index].minute}분');
                              },
                            ),
                          ),

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(18),
                            decoration: BoxDecoration(color: Colors.white),
                            child: LocationRow(),
                          ),

                          const SizedBox(height: 30),


                          // 투표게시글 생성 버튼
                          ElevatedButton(
                              onPressed: () async {
                                print(times);
                                print(dates);
                                print(setCategory);
                                print(setLocation);


                                CreateVotingDto createVotingDto = CreateVotingDto(
                                    title: _titlecontroller.text,
                                    categories: setCategory,
                                    locations: setLocation,
                                    times: times,
                                    dates: dates,
                                    );

                                print('write voting request body');
                                print(createVotingDto);

                                _user_controller.writeVoting(groupId: widget.groupId, createVotingDto: createVotingDto);

                                Navigator.push(context, MaterialPageRoute(builder: (context) => DateVotingPage(groupId: widget.groupId)));
                              },

                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                padding: const EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
                              ),
                              child: const Text('투표 생성하기', style: TextStyle(
                                color: Colors.white,
                                fontFamily: "netmarbleB",
                                fontSize: 14,
                              )
                              ),
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
            '제목을 입력해주세요.',
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
            '1. 날짜를 선택해주세요.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),
          //'${date.year}. ${date.month}. ${date.day}'
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 200),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month, color: Colors.green, size: 30),
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
                  //date = newDate;
                  dateTime = newDate;
                  Dcount += 1;
                  createMeetingDate = CreateMeetingDate(year: dateTime!.year , month: dateTime!.month, day: dateTime!.day);
                  //dates.add('${dateTime!.year}. ${dateTime!.month}. ${dateTime!.day}');
                  dates.add(createMeetingDate);
                  print(dates);
                });
              },
              style: ElevatedButton.styleFrom(
                  elevation: 4,
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
            '2. 시간을 설정해주세요.',
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
              icon: const Icon(Icons.more_time, color: Colors.green, size: 30),
              label: Text('$time', style: const TextStyle(color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
              onPressed: () async {
                TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now());

                if(newTime != null) {
                  setState(() {
                    //time = newTime.format(context);
                    timeOfDay = newTime;
                    Tcount += 1;
                    createMeetingTime = CreateMeetingTime(hour: timeOfDay!.hour, minute: timeOfDay!.minute);
                    times.add(createMeetingTime);
                    //times.add('${timeOfDay!.hour}:${timeOfDay!.minute}');
                    print(times);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 4,
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
            '3. 장소를 설정해주세요.',
            style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: "netmarbleM"
            ),
          ),

          SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 60),
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 200),
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
              SizedBox(width: 20),
              IconButton(
                  icon: Icon(Icons.add, color: Colors.green, size: 30),
                  onPressed: () {
                    setState(() {
                      Lcount += 1;
                      setLocation.add(_locationcontroller.text);
                      _locationcontroller.text = " ";
                      print(setLocation);
                    });
                  }
              ),
            ],
          ),

          SizedBox(height: 5),

          Container(
            height: 12,
            child: Text(
              '투표할 장소: ${setLocation.toString()}',
              style: const TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontFamily: "netmarbleM"
            )),
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
