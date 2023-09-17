import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccermate/repository/user_repository.dart';



class GroupUserPage extends StatefulWidget {
  const GroupUserPage({Key? key}) : super(key: key);
  static const route = "/groupuserpage";

  @override
  _GroupUserPageState createState() => _GroupUserPageState();
}

class _GroupUserPageState extends State<GroupUserPage> {
  final formKey = GlobalKey<FormState>();
  late final double maxImageWidth;
  late final double maxImageHeight;
  String buttonText = '가입하기';
  Color color = Colors.green;
  bool _hasBeenPressed = false;
  XFile? _Gimage;
  //late SetInfoArguments infos;
  //late User_Controller _user_controller;


  Widget _setImage(){
    print("setImage callled!");
    if(_Gimage == null) {
      return const Icon(Icons.construction);
    } else {
      return Image.file(File(_Gimage!.path), fit: BoxFit.fill);
    }
  }


  @override
  void initState() {
    //_user_controller = User_Controller();

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



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE7E7E7),
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: WidgetsWidth,
                height: 350,
                child: Stack(
                  children: <Widget> [

                    Positioned(
                      top: 0,
                      child: Container(
                        width: WidgetsWidth,
                        height: 350,
                        color: Colors.blue,
                        //child: _setImage(),  // 모임 대표 이미지 보여주기
                      ),
                    ),

                    Positioned(
                        top: 50,
                        left: 20,
                        child: Container(
                          width: WidgetHeight,
                          height: 350,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const BackButton(color: Colors.white),
                                spacer(4),

                                Bottom1Row(),
                                spacer(1),
                                Bottom2Row()
                              ]
                          ),
                        )
                    ),
                  ],
                ),
              ),

              spacer(1),
              text1Row(),
              spacer(1),
              ContantRow(),
              spacer(6),

              Container(
                width: WidgetsWidth,
                height: 200,
                color: Color(0xFFD3D3D3),
                child: text2Row(),
              )

            ],
          ),
        )
      ),
    );
  }


  // 모임 대표이미지 내부 콘텐츠들
  Flexible Bottom1Row() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(width: 20),

          const Text(
            '모임 제목',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: "netmarbleB",
            ),
          ),

          const SizedBox( width: 150),

          OutlinedButton.icon(
            onPressed: () async {

            },
            icon: const Icon(
              Icons.person,
              size: 25,
              color: Colors.white,
            ),
            style: OutlinedButton.styleFrom(
                side: BorderSide(width: 2, color: Colors.white),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
            ),
            label: Text(' 11 ', style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: "netmarbleB"),),
          )
        ],
      ),
    );
  }


  Flexible Bottom2Row() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox( width: 20),

          const Text(
            '오픈채팅 링크',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "netmarbleB",
              decoration: TextDecoration.underline,
            ),
          ),

          SizedBox( width: 150),

          ElevatedButton(
            onPressed: () async {
              showDialog (
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text('가입 요청을 하였습니다. \n방장이 승인 시, 가입이 완료됩니다.'),
                      actions: <Widget> [
                        TextButton(
                            child: Text('확인'),
                            onPressed: () { Navigator.of(context).pop();}
                        ),
                      ],
                    );
                  }
              );
              setState(() {
                buttonText = '가입대기';
                color = Colors.grey;
              });
            },
            style: ElevatedButton.styleFrom(
                primary: color,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)
                )
            ),
            child: Text(
                '$buttonText',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 18
                )
            ),
          ),

        ],
      ),
    );
  }





// 모임 소개글
  Flexible text1Row() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [

          SizedBox(width: 30),

          Icon(Icons.wb_twilight, size: 20, color: Colors.black),

          Flexible(
            flex: 4,
            child: Text(
              '  모임 소개',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "netmarbleB",
              ),
            ),
          ),

        ],
      ),
    );
  }


  Flexible ContantRow() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [

          SizedBox(width: 60),

          Flexible(
            flex: 5,
            child: Text(
              '내용 -------------',
              style: TextStyle(
                fontSize: 11,
                fontFamily: "netmarbleL",
              ),
            ),
          ),

        ],
      ),
    );
  }


  Flexible text2Row() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [

          Flexible(
            flex: 5,
            child: Text(
              '가입을 진행해주세요.',
              style: TextStyle(
                color: Color(0xFF646464),
                fontSize: 14,
                fontFamily: "netmarbleB",
              ),
            ),
          ),

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

