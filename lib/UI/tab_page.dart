import 'package:flutter/material.dart';
import 'package:soccermate/UI/home_page.dart';
import 'package:soccermate/UI/newPw_page.dart';
import 'package:soccermate/UI/setInfo1_page.dart';
import 'package:soccermate/UI/signupClear_page.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/repository/user_repository.dart';
import 'package:http/http.dart' as http;

import 'package:soccermate/exception/CodeNotCheckException.dart';
import 'package:soccermate/exception/LogInFailedException.dart';
import '../exception/CodeNotSentException.dart';
import '../exception/EmailDuplicatedException.dart';
import '../exception/EmailUnformatException.dart';



class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);
  static const route = "/tabpage";

  @override
  _TabPageState createState() => _TabPageState();

 //static const url = Uri.parse('https://accounts.google.com/ServiceLogin/identifier?service=accountsettings&continue=https%3A%2F%2Fmyaccount.google.com%3Futm_source%3Daccount-marketing-page%26utm_medium%3Dgo-to-account-button&flowName=GlifWebSignIn&flowEntry=ServiceLogin');
}


class _TabPageState extends State<TabPage> with TickerProviderStateMixin {
  late String _userEmail, _userPassword = "";
  late TabController _tabController;
  late TextEditingController _loginemail;
  late TextEditingController _loginpassword;
  late TextEditingController _signupemail;
  late TextEditingController _signuppassword;
  late TextEditingController _signupcode;
  late User_Controller _user_controller;
  final formKey = GlobalKey<FormState>();


  Color beforeColor1 = Color(0xFFA6DCA8);
  Color beforeColor2 = Color(0xFFA6DCA8);

  String text1 = '확인';



  @override
  void initState() {
    _tabController = TabController(
        length: 2,
        vsync: this,
    );
    _user_controller = User_Controller();
    _loginemail = TextEditingController(text: "");
    _loginpassword = TextEditingController(text: "");
    _signupemail = TextEditingController(text: "");
    _signuppassword = TextEditingController(text: "");
    _signupcode = TextEditingController(text: "");

    super.initState();
  }


  @override
  void dispose() {
    _tabController.dispose();
    _loginemail.dispose();
    _loginpassword.dispose();
    _signupemail.dispose();
    _signuppassword.dispose();
    _signupcode.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    _tabController.animateTo(0);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double signUpWidgetsWidth = screenWidth * 0.8;
    final double signUpWidgetHeight = screenHeight * 0.6;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            resizeToAvoidBottomInset : true,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(170.0),

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
                bottom: TabBar(
                  labelColor:Colors.black,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                    ),
                    color: Colors.white
                ),
                tabs: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: const Text(
                      '로그인',
                      style: TextStyle(
                        fontSize: 17,
                        fontFamily: "netmarbleB",
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "netmarbleB",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
              controller: _tabController,
              children: [
                Center( // 로그인 화면
                  child: Container(
                    height: signUpWidgetHeight,
                    width: signUpWidgetsWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        spacer(2),
                        loginEmailRow(),
                        spacer(1),
                        loginPasswordRow(),
                        newPasswordRow(),
                        spacer(2),  // 비밀번호 재설정
                        loginBtnRow(),
                        spacer(1),
                        loginGoogleBtnRow(),
                        spacer(2),
                      ],
                    ),
                  ),
                ),


                Center(  // 회원가입 화면
                  child: Container(
                    width: signUpWidgetsWidth,
                    height: signUpWidgetHeight,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        spacer(2),
                        signUpEmailRow(),
                        spacer(1),
                        signUpCodeRow(),
                        spacer(1),
                        signUpPasswordRow(),
                        spacer(3),
                        signUpBtnRow(),
                        spacer(2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      );
  }


  // 로그인 화면
  Flexible loginEmailRow() {
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 13,
            child: TextFormField(
              controller: _loginemail,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
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
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible loginPasswordRow() {
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 13,
            child: TextFormField(
              controller: _loginpassword,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    height: 0.8,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF3ABB3E), width: 3),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible newPasswordRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 13,
            child: TextButton(
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed( 루트 );
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NewPwPage()),
                );
              },
              style: TextButton.styleFrom(
                primary: Colors.grey,
                padding: const EdgeInsets.all(10),
                textStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.grey,
                  fontFamily: "netmarbleM",
                  fontSize: 13,
                ),
              ),
              child: const Text('비밀번호 재설정'),
            ),
          ),
        ],
      ),
    );
  }


  Flexible loginBtnRow() {
    return Flexible(
      flex: 5,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 10,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  int r = await login();
                  if (r == 0) {
                    // 페이지 이동 -> 메인 페이지 (회원인 경우)
                    Navigator.of(context).pushNamed(HomePage.route);
                  } else {
                    // 페이지 이동 -> 유저정보설정 (비회원인 경우)
                    Navigator.of(context).pushNamed(SetInfo1Page.route);
                  }
                } on LoginFailedException catch(e){
                  // 팝업창 or 하단 오류메세지
                }

              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3ABB3E),
                padding: const EdgeInsets.only(left: 140, right: 140, top: 15, bottom: 15),
              ),
              child: const Text('로그인', style: TextStyle(
                color: Colors.white,
                fontFamily: "netmarbleB",
                fontSize: 14,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Flexible loginGoogleBtnRow() {   // 로고 삽입
    return Flexible(
      flex: 4,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFE0E0E0),
                  padding: const EdgeInsets.only(left: 20, right: 20, top:10, bottom: 10),
                ),
                  onPressed: () async {

                    },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('images/glogo.png'),
                      const Text(
                        '구글 계정으로 로그인',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "netmarbleB",
                          fontSize: 14,
                        ),
                      ),
                      Opacity(opacity: 0.0, child: Image.asset('images/glogo.png'),)
                    ],
                  )
              ),
          ),
        ],
      ),
    );
  }


  // 회원가입 화면
  Flexible signUpEmailRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 14,
              child: TextFormField(   // 이메일 입력칸
                controller: _signupemail,
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
                    signup_send();
                  } on EmailDuplicatedException catch(e){
                    print(e);
                    // 팝업창 or 하단 오류메세지
                  } on EmailUnformatException catch(e) {
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
                    fontSize: 13,
                  ),
                ),
                child: const Text('인증번호 \n    받기')
            ),
          )
        ],
      ),
    );
  }



  Flexible signUpCodeRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 14,
              child: TextFormField(   // 인증번호 입력칸
                controller: _signupcode,
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
                    signup_check();
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


  Flexible signUpPasswordRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              flex: 14,
              child: TextFormField(
                controller: _signuppassword,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "netmarbleB",
                ),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호',
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


  Flexible signUpBtnRow() {
    return Flexible(
      flex: 5,
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
                    signup();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupClearPage()));

                  } on EmailDuplicatedException catch(e){
                    // 팝업창 or 하단 오류메세지
                  } on CodeNotSentException catch(e) {

                  } on EmailUnformatException catch(e) {

                  }on CodeNotCheckException catch(e){

                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: beforeColor2,
                  padding: const EdgeInsets.only(top:15, bottom:15),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 16,
                  ),
                ),
                child: const Text('가입하기')
            ),
          ),
        ],
      ),
    );
  }


  Future<int> login() {
    String email = _loginemail.text;
    String password = _loginpassword.text;

    print("email : " + email + " password :  " + password);

    return _user_controller.login(email: email, password: password);
  }

  Future<void> signup_send() {
    String email = _signupemail.text;

    print("email : " + email);

    return _user_controller.signup_send(email: email);
  }

  Future<void> signup_check() {
    String email = _signupemail.text;
    String code= _signupcode.text;

    print("email : " + email + " code :  " + code);

    return _user_controller.signup_check(email: email, code: code);
  }

  Future<void> signup() {
    String email = _signupemail.text;
    String password = _signuppassword.text;

    print("email : " + email + " password :  " + password);

    return _user_controller.signup(email: email, password: password);
  }


  Widget spacer(int flex)
  {
    return Flexible(
      flex: flex,
      child: Container()
    );
  }

}



