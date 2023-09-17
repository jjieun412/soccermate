import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccermate/UI/dto/setInfo_data.dart';
import 'package:soccermate/UI/setInfo3_page.dart';
import 'package:soccermate/UI/makeGroup3_page.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../controller/user_controller.dart';
import '../main.dart';
import 'dto/makeGroup_data.dart';



class MakeGroup2Page extends StatefulWidget {
  const MakeGroup2Page({Key? key}) : super(key: key);
  static const route = "/makegroup2page";

  @override
  _MakeGroup2PageState createState() => _MakeGroup2PageState();

}



class _MakeGroup2PageState extends State<MakeGroup2Page> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _groupContent;
  late User_Controller _user_controller;
  String GName = "";

  @override
  void initState() {
    _user_controller = User_Controller();
    _groupContent = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _groupContent.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.8;


    // 모임 이름(제목) 데이터 가져오기
    GName  = ModalRoute.of(context)!.settings.arguments as String;
    print(GName);



    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Padding(
            padding: EdgeInsets.only(top:35),
            child: Text(
              '모임 생성',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: "netmarbleB"
              ),
            ),
          ),
          leading: const Padding(
            padding: EdgeInsets.only(left: 20, top:28),
            child: BackButton(
              color: Colors.grey,
            ),
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

      body: Container(
        height: WidgetHeight,
        width: WidgetsWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            spacer(5),

            text1Row(),
            GroupContentRow(),  // 모임 소개글
            spacer(3),

            movePageBtnRow(),
            spacer(3),

          ],
        ),
      ),
    );
  }



  Flexible text1Row() {
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 50,
          ),
          Flexible(
            flex: 20,
            child: Text(
              '2. 모임을 소개해주세요. ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "netmarbleB",
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible GroupContentRow() {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 50,
          ),
          Flexible(
            flex: 8,
            child: TextFormField(
              controller: _groupContent,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3),
                ),
              ),

            ),
          ),
          const SizedBox(
            width: 50,
          ),
        ],
      ),
    );
  }


  Flexible movePageBtnRow() {
    return Flexible(
      flex: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: ElevatedButton(   // 이전 버튼
                onPressed: () async {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFF7F7F7),
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                ),
                child: const Text(
                  '이전',
                  style: TextStyle(
                    color: Color(0xFFA3A3A3),
                    fontFamily: "netmarbleM",
                    fontSize: 14,
                  ),
                )
            ),
          ),
          spacer(2),
          Flexible(
            flex: 10,
            child: ElevatedButton(    // 다음 버튼
                onPressed: () async {
                  // 모임 제목과 소개글 전송
                  GroupInfoArguments temp = GroupInfoArguments(GName, _groupContent.text);
                  Navigator.pushNamed(context, MakeGroup3Page.route, arguments: temp);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.green,
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleM",
                    fontSize: 14,
                  ),
                ),
                child: const Text('다음')
            ),
          )
        ],
      ),
    );
  }


  Widget spacer(int flex)
  {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }

}