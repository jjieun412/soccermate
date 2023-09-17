import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccermate/UI/dto/setInfo_data.dart';
import 'package:soccermate/UI/setInfo3_page.dart';
import 'package:soccermate/UI/makeGroup2_page.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../controller/user_controller.dart';
import 'dto/makeGroup_data.dart';


class MakeGroup1Page extends StatefulWidget {
  const MakeGroup1Page({Key? key}) : super(key: key);
  static const route = "/makegroup1page";

  @override
  _MakeGroup1PageState createState() => _MakeGroup1PageState();

}



class _MakeGroup1PageState extends State<MakeGroup1Page> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _groupName;
  late User_Controller _user_controller;

  @override
  void initState() {
    _user_controller = User_Controller();
    _groupName = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _groupName.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.8;



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
            spacer(1),
            GroupNameRow(),  // 모임이름
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
              '1. 모임의 이름을 입력해주세요. ',
              style: TextStyle(
                fontSize: 16,
                fontFamily: "netmarbleB",
              ),
            ),
          ),

          Flexible(
            flex: 10,
            child: Text(
              '  (최대 15자) ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10,
                fontFamily: "netmarbleL",
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible GroupNameRow() {
    return Flexible(
      flex: 3,
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
              controller: _groupName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
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
                  // 모임 이름 데이터 다음 페이지로 이동
                  Navigator.pushNamed(context, MakeGroup2Page.route, arguments: _groupName.text);
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