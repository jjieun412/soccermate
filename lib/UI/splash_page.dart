import 'package:flutter/material.dart';
import 'package:soccermate/UI/tab_page.dart';
import 'package:soccermate/repository/user_repository.dart';

import 'myInfo_page.dart';



class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const route = "/splashpage";

  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {
  final formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    _navigateToHome(context);
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


    return Scaffold(
      body: Container(
          height: WidgetHeight,
          width: WidgetsWidth,
        child:Image.asset("images/launch_screen.png", fit: BoxFit.fill,)
        ),
      );
  }

  void _navigateToHome(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 1000), (){});
    Navigator.pushNamed(context, TabPage.route);
  }

}