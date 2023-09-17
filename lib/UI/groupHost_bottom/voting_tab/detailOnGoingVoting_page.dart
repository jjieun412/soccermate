import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/data/voting/DoVotingDto.dart';
import 'package:soccermate/data/voting/VotingItemsDetail.dart';
import 'package:soccermate/data/voting/votingCategory_op.dart';
import 'package:soccermate/data/voting/votingDate_op.dart';
import 'package:soccermate/data/voting/votingLocation_op.dart';
import 'package:soccermate/data/voting/votingTime_op.dart';

import '../../../data/voting/VotingItemsDetail.dart';
import '../../../data/voting/VotingItemsDetail.dart';
import '../dateVoting_page.dart';




class DetailOnGoingVotingPage extends StatefulWidget {
  late int groupId;
  late int voteId;
  DetailOnGoingVotingPage({required int groupId, required int voteId, Key? key}) : super(key: key){
    this.groupId = groupId;
    this.voteId = voteId;
  }
  static const route = "/ongoingvotingpage";

  @override
  _DetailOnGoingVotingPageState createState() => _DetailOnGoingVotingPageState();
}


class _DetailOnGoingVotingPageState extends State<DetailOnGoingVotingPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;

  late int dateId, timeId, locationId, categoryId;
  late List<int> optionId = [];
  late List<int> _selectedItem = [];
  var _isChecked = false;


  @override
  void initState() {
    _user_controller = User_Controller();
    dateId = 0;
    timeId = 0;
    locationId = 0;
    categoryId = 0;
    _isChecked = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 각 카테고리별 추가될 라디오 버튼 Row
  // 날짜
  Widget _radioList1(int opId, String temp) {
    return RadioListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        title: Text(temp, style: TextStyle(fontFamily: "netMarbleM", fontSize: 13)),
        value: temp,
        groupValue: null,
        onChanged: (value) {
          setState(() {
            dateId = opId;
            print(dateId);  // optionId 프린트
            temp = value!;
          });
        },
    );
  }

  // 시간
  Widget _radioList2(int opId, String temp) {
    return RadioListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(temp, style: TextStyle(fontFamily: "netMarbleM", fontSize: 13)),
      value: temp,
      groupValue: null,
      onChanged: (value) {
        setState(() {
          timeId = opId;
          print(timeId);
          temp = value!;
        });
      },
    );
  }

  // 종목
  Widget _radioList3(int opId, String temp) {
    return RadioListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(temp, style: TextStyle(fontFamily: "netMarbleM", fontSize: 13)),
      value: temp,
      groupValue: null,
      onChanged: (value) {
        setState(() {
          categoryId = opId;
          print(categoryId);
          temp = value!;
        });
      },
    );
  }

  // 장소
  Widget _radioList4(int opId, String temp) {
    return RadioListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      title: Text(temp, style: TextStyle(fontFamily: "netMarbleM", fontSize: 13)),
      value: temp,
      groupValue: null,
      onChanged: (value) {
        setState(() {
          locationId = opId;
          print(locationId);
          temp = value!;
        });
      },
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
          body: FutureBuilder<VotingItemsDetail> (
            future: _user_controller.detailVotingItems(groupId: widget.groupId, voteId: widget.voteId),
            builder: (BuildContext context, AsyncSnapshot<VotingItemsDetail> snapshot) {
              if(snapshot.hasData) {
                print("snapshot has detail VotingItems data");
                VotingItemsDetail getDetailVoting = snapshot.data!;
                List<detailDates> getDate = snapshot.data!.dates.dateOption_list;
                List<detailLocations> getLocation = snapshot.data!.locations.locationOption_list;
                List<detailTimes> getTime = snapshot.data!.times.timeOption_list;
                List<detailCategories> getCategory = snapshot.data!.categories.categoryOption_list;


                return SafeArea(
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
                                const SizedBox(height: 30),
                                Container(
                                  height: 70,
                                  width: WidgetWidth,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Text('<< ${getDetailVoting.title} >>', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: "netmarbleB")),
                                ),
                                const SizedBox(height: 20),


                                // 날짜
                                Container(
                                  width: WidgetWidth,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      SizedBox(width: 20),
                                      Text('날짜   ', style: TextStyle(fontSize: 16, fontFamily: "netmarbleM")),
                                      Icon(Icons.calendar_month),
                                    ],
                                  ),

                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: getDate.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return _radioList1(getDate[index].option_id, '${getDate[index].month}월 ${getDate[index].day}일');
                                    }
                                   )
                                    ]
                                  ),
                              ),

                                const SizedBox(height: 12),

                                // 시간
                                Container(
                                  width: WidgetWidth,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: const [
                                          SizedBox(width: 20),
                                          Text('시간   ', style: TextStyle(fontSize: 16, fontFamily: "netmarbleM")),
                                          Icon(Icons.access_time_outlined),
                                        ],
                                        ),
                                        ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: getTime.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return _radioList2(getTime[index].option_id, '${getTime[index].hour}시 ${getTime[index].minute}분');
                                        }
                                        )
                                        ])),
                                const SizedBox(height: 12),


                                // 카테고리
                                Container(
                                  width: WidgetWidth,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                  child:  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 20),
                                          Text('종목   ', style: TextStyle(fontSize: 16, fontFamily: "netmarbleM")),
                                          Icon(Icons.sports_soccer),
                                        ],
                                      ),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: getCategory.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return _radioList3(getCategory[index].option_id, '${getCategory[index].category_name}');
                                          }
                                      )
                                    ]
                                  ),
                                ),
                                const SizedBox(height: 12),


                                // 장소
                                Container(
                                  width: WidgetWidth,
                                  padding: EdgeInsets.all(18),
                                  decoration: BoxDecoration(color: Colors.white),
                                    child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: const [
                                                  SizedBox(width: 20),
                                                  Text('장소   ', style: TextStyle(fontSize: 16, fontFamily: "netmarbleM")),
                                                  Icon(Icons.location_on),
                                                ],
                                              ),
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: getLocation.length,
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return _radioList4(getLocation[index].option_id, '${getLocation[index].location_name}');
                                                  }
                                              )
                                            ]
                                        )
                                    ),

                                    const SizedBox(height: 20),



                                ElevatedButton(
                                  onPressed: () async {
                                    DoVotingDto doVotingDto = DoVotingDto(date_option_id: dateId, times_option_id: timeId, location_option_id: locationId, category_option_id: categoryId);
                                    print('Success: do Voting request body');
                                    print(doVotingDto);

                                    _user_controller.doVoting(groupId: widget.groupId, voteId: widget.voteId, doVotingDto: doVotingDto);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DateVotingPage(groupId: widget.groupId)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    padding: const EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
                                  ),
                                  child: const Text('투표 하기', style: TextStyle(
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
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          )
      )
    );
  }





  Flexible TimeRow(int Id, String time) {
    return Flexible(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text('시간   ', style: TextStyle(fontSize: 14, fontFamily: "netmarbleM")),
                Icon(Icons.access_time_outlined),
              ],
            ),
            _radioList2(Id, time)
          ],
        )
    );
  }
/*

  Flexible CategoryRow() {
    return Flexible(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text('종목   ', style: TextStyle(fontSize: 14, fontFamily: "netmarbleM")),
                Icon(Icons.sports_soccer),
              ],
            ),
            _radioList('축구'),
            _radioList('풋살'),
          ],
        )
    );
  }

 */


  Flexible LocationRow(int Id, String location) {
    return Flexible(
        flex: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget> [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text('장소   ', style: TextStyle(fontSize: 14, fontFamily: "netmarbleM")),
                Icon(Icons.location_on),
              ],
            ),
            _radioList4(Id, location)
          ],
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