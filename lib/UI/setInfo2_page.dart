import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soccermate/UI/dto/setInfo_data.dart';
import 'package:soccermate/UI/setInfo1_page.dart';
import 'package:soccermate/UI/setInfo3_page.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../controller/user_controller.dart';


class SetInfo2Page extends StatefulWidget {
  const SetInfo2Page({Key? key}) : super(key: key);
  static const route = "/setinfo2page";

  @override
  _SetInfo2PageState createState() => _SetInfo2PageState();

}



class _SetInfo2PageState extends State<SetInfo2Page> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nickname;
  late User_Controller _user_controller;
  String Location = "";

  @override
  void initState() {
    _user_controller = User_Controller();
    _nickname = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.8;


    // 설정 지역 데이터 가져오기
    Location = ModalRoute.of(context)!.settings.arguments as String;
    print(Location);



    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            '유저 정보 설정',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "netmarbleB"
            ),
          ),
          leading: const BackButton(
            color: Colors.grey,
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
              spacer(1),
              Image.asset('images/setinfo_icons.png', scale: 1),
              spacer(2),
              text1Row(),
              spacer(3),

              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 1),),
                ),
              ),
              spacer(10),

              text2Row(),   // 닉네임 입력해주세요
              spacer(3),
              NicknameRow(),  // 닉네임 입력칸
              spacer(5),


              movePageBtnRow(),
              spacer(3),

            ],
          ),
        ),
      );
  }


  Flexible text1Row() {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Flexible(
            flex: 10,
            child: Text(
              '입력해주시는 정보 설정에 따라\n 회원님에게 맞는 메이트 그룹을 찾는데 도움을 드리고자 합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  fontFamily: "netmarbleM"
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible text2Row() {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          SizedBox(
            width: 50,
          ),
          Flexible(
            flex: 10,
            child: Text(
              '닉네임을 입력해주세요.',
              style: TextStyle(
                fontSize: 15,
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


  Flexible NicknameRow() {
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
            child: TextField(
              controller: _nickname,
              /*
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]{3,15}$'))
              ],

               */
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 2),
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
                  SetInfoArguments temp = SetInfoArguments(Location, _nickname.text);
                  Navigator.pushNamed(context, SetInfo3Page.route, arguments: temp);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Color(0xFF3ABB3E),
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