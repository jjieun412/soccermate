import 'package:flutter/material.dart';
import 'package:soccermate/exception/IncorrectCodeException.dart';
import 'package:soccermate/exception/PWUnformatException.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../controller/user_controller.dart';
import '../exception/CodeNotCheckException.dart';
import '../exception/CodeNotSentException.dart';
import '../exception/EmailDuplicatedException.dart';
import 'newPwClear_page.dart';


class NewPwPage extends StatefulWidget {
  const NewPwPage({Key? key}) : super(key: key);
  static const route = "/newpwpage";

  @override
  _NewPwPageState createState() => _NewPwPageState();

}

class _NewPwPageState extends State<NewPwPage> with TickerProviderStateMixin {

  late TextEditingController _newpwemail;
  late TextEditingController _newpwpassword;
  late TextEditingController _newpwcode;
  late User_Controller _user_controller;
  final formKey = GlobalKey<FormState>();

  Color beforeColor1 = Color(0xFFA6DCA8);
  Color beforeColor2 = Color(0xFFA6DCA8);

  String text1 = '확인';



  @override
  void initState() {
    _user_controller = User_Controller();
    _newpwemail = TextEditingController(text: "");
    _newpwpassword = TextEditingController(text: "");
    _newpwcode = TextEditingController(text: "");
    super.initState();
  }


  @override
  void dispose() {
    _newpwemail.dispose();
    _newpwpassword.dispose();
    _newpwcode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.7;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF3ABB3E),
          resizeToAvoidBottomInset : false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: AppBar(
              backgroundColor: Color(0xFF3ABB3E),
              elevation: 0,
              title: Container(
                padding: EdgeInsets.only(top:15),
                height: 80,
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      scale: 1,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'soccer mate',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "netmarbleB",
                      ),
                    ),
                    Opacity(opacity: 0.0, child: Image.asset('images/logo.png'),)
                  ],
                ),
              ),
            ),
          ),
          body: Center(
              child: Container(
                width: WidgetWidth,
                height: WidgetHeight,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    spacer(2),

                    Container(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: Color(0xFF3ABB3E), width: 1),),
                      ),
                      child: const Text('비밀번호 재설정',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: "netmarbleB",
                          )),
                    ),

                    spacer(1),
                    gotoLoginRow(),
                    spacer(2),
                    newPwEmailRow(),
                    spacer(1),
                    newPwCodeRow(),
                    spacer(1),
                    newPwPasswordRow(),
                    spacer(4),
                    newPwBtnRow(),
                    spacer(2),
                  ],
                ),
              ),
            ),
          ),
    );
  }


  // 비밀번호 재설정 화면
  Flexible gotoLoginRow() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 13,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                  fontFamily: "netmarbleM",
                  fontSize: 12,
                ),
              ),
              child: const Text('로그인 페이지로 돌아가기'),
            ),
          ),
        ],
      ),
    );
  }


  Flexible newPwEmailRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 14,
              child: TextFormField(   // 이메일 입력칸
                controller: _newpwemail,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "netmarbleB",
                ),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '이메일',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    )
                ),
              )
          ),
          spacer(1),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: ElevatedButton(    // 인증번호 전송 버튼
                onPressed: () async {
                  try {
                    newPw_send();
                  } on PWUnformatException catch(e){
                    print(e);
                    // 팝업창 or 하단 오류메세지
                  } on EmailDuplicatedException catch(e) {
                    print(e);
                  }
                  setState(() {
                    beforeColor1 = Color(0xFF3ABB3E);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3ABB3E),
                  padding: const EdgeInsets.all(10.0),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 12,
                  ),
                ),
                child: const Text('인증번호 \n    받기')
            ),
          )
        ],
      ),
    );
  }



  Flexible newPwCodeRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 14,
              child: TextFormField(   // 인증번호 입력칸
                controller: _newpwcode,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "netmarbleB",
                ),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '인증번호',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    )
                ),
              )
          ),
          spacer(1),
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: ElevatedButton(    //인증번호 확인 버튼
                onPressed: () async {
                  try {
                    newPw_check();
                    setState(() {
                      text1 = '인증 완료';
                      beforeColor2 = Color(0xFF3ABB3E);
                    });
                  } on CodeNotSentException catch(e) {

                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: beforeColor1,
                  padding: const EdgeInsets.all(15.0),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 14,
                  ),
                ),
                child: Text('${text1}')
            ),
          )
        ],
      ),
    );
  }


  Flexible newPwPasswordRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 13,
              child: TextFormField(
                controller: _newpwpassword,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "netmarbleB",
                ),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '변경할 비밀번호',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                    )
                ),
              )
          ),
        ],
      ),
    );
  }


  Flexible newPwBtnRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 13,
            fit: FlexFit.tight,
            child: ElevatedButton(
                onPressed: () async {
                  try {
                    newPw();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPwClearPage()),
                    );
                  } on EmailDuplicatedException catch(e){
                    // 팝업창 or 하단 오류메세지
                  } on IncorrectCodeException catch(e) {

                  } on PWUnformatException catch(e) {

                  } on CodeNotCheckException catch(e){

                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: beforeColor2,
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 16,
                  ),
                ),
                child: const Text('비밀번호 재설정')
            ),
          ),
        ],
      ),
    );
  }


  Future<void> newPw_send()
  {
    String email = _newpwemail.text;

    print("email : " + email);

    return _user_controller.newPw_send(email: email);

  }

  Future<void> newPw_check()
  {
    String email = _newpwemail.text;
    String code= _newpwcode.text;

    print("email : " + email + " code :  " + code);

    return _user_controller.newPw_check(email: email, code: code);
  }

  Future<void> newPw()
  {
    String email = _newpwemail.text;
    String password = _newpwpassword.text;

    print("email : " + email + " password :  " + password);

    return _user_controller.newPw(email: email, password: password);

  }


  Widget spacer(int flex)
  {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }
}