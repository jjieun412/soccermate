import 'package:flutter/material.dart';
import 'package:soccermate/UI/home_bottom/myGroupList_page.dart';
import 'package:soccermate/UI/home_bottom/point_page.dart';
import 'package:soccermate/UI/home_bottom/showGroupList_page.dart';
import 'package:soccermate/UI/makeGroup1_page.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/repository/user_repository.dart';

import '../data/soccerGroupSearchDtos/groupList.dart';
import 'myInfo_page.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const route = "/homepage";

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  final formKey = GlobalKey<FormState>();
  final User_Controller user_controller = User_Controller();

  @override
  void initState() {
    super.initState();

  }


  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 1;
/*
  static const List<Widget> _widgetOptions = <Widget> [
    Text('Index 0: List'),
    Text('Index 1: Home'),
    Text('Index 2: Point'),
  ];
 */
  static const List<Widget> _widgetOptions = <Widget> [
    MyGroupListPage(),
    ShowGroupListPage(),
    PointPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 0.8;
    final double WidgetHeight = screenHeight * 0.6;


    return Scaffold(

        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MakeGroup1Page.route);
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, size: 40, ),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.list, size: 40,), label: '나의 모임',),
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 40,), label: '홈',),
            BottomNavigationBarItem(icon: Icon(Icons.attach_money, size: 40,), label: '포인트',),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          selectedFontSize: 15,
          unselectedFontSize: 15,
          onTap: _onItemTapped,
        ),
    );
  }


  Widget spacer(int flex) {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }

}