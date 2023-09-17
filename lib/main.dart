import 'package:flutter/material.dart';

import 'package:soccermate/UI/home_page.dart';
import 'package:soccermate/UI/myInfo_page.dart';
import 'package:soccermate/UI/newPwClear_page.dart';
import 'package:soccermate/UI/newPw_page.dart';
import 'package:soccermate/UI/signupClear_page.dart';
import 'package:soccermate/UI/splash_page.dart';
import 'package:soccermate/UI/tab_page.dart';
import 'package:soccermate/UI/setInfo2_page.dart';

import 'UI/setInfo1_page.dart';
import 'UI/setInfo3_page.dart';
import 'UI/makeGroup1_page.dart';
import 'UI/makeGroup2_page.dart';
import 'UI/makeGroup3_page.dart';
import 'UI/groupUser_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      routes: {
        SplashPage.route: (context) => const SplashPage(),
        TabPage.route: (context) => const TabPage(),
        SignupClearPage.route: (context) => const SignupClearPage(),

        NewPwPage.route: (context) => const NewPwPage(),
        NewPwClearPage.route: (context) => const NewPwClearPage(),

        SetInfo1Page.route: (context) => const SetInfo1Page(),
        SetInfo2Page.route: (context) => const SetInfo2Page(),
        SetInfo3Page.route: (context) => const SetInfo3Page(),

        HomePage.route: (context) => const HomePage(),
        MyInfoPage.route: (context) => const MyInfoPage(),

        MakeGroup1Page.route: (context) => const MakeGroup1Page(),
        MakeGroup2Page.route: (context) => const MakeGroup2Page(),
        MakeGroup3Page.route: (context) => const MakeGroup3Page(),

        GroupUserPage.route: (context) => const GroupUserPage(),

      },
      
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF3ABB3E),
        textTheme: const TextTheme(
          headline1: TextStyle(fontFamily: "netmarbleM"),
          bodyText1: TextStyle(fontFamily: "netmarbleM"),
        ),
      ),
      home: SplashPage(),
    );
  }
}







