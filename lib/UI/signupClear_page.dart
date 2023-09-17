import 'package:flutter/material.dart';
import 'package:soccermate/repository/user_repository.dart';
import 'package:soccermate/UI/tab_page.dart';


class SignupClearPage extends StatefulWidget {
  const SignupClearPage({Key? key}) : super(key: key);
  static const route = "/signupclearpage";

  @override
  _SignupClearPageState createState() => _SignupClearPageState();

}

class _SignupClearPageState extends State<SignupClearPage> with TickerProviderStateMixin {

  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
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
    final double WidgetHeight = screenHeight * 0.65;


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

        body: Center(  // 회원가입 화면
          child: Container(
            width: WidgetsWidth,
            height: WidgetHeight,
            padding: EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                spacer(4),
                const Text('회원가입이 완료되었습니다!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "netmarbleB",
                    )),
                spacer(4),
                newPwClearBtnRow(),
                spacer(2),
              ],
            ),
          ),
        ),
      ),
    );
  }


  // 비밀번호 재설정 화면
  Flexible newPwClearBtnRow() {
    return Flexible(
      flex: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 13,
            fit: FlexFit.tight,
            child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const TabPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3ABB3E),
                  padding: const EdgeInsets.all(15.0),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleB",
                    fontSize: 16,
                  ),
                ),
                child: const Text('로그인하기')
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