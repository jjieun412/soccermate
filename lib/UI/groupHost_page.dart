import 'package:flutter/material.dart';
import 'package:soccermate/UI/groupHost_bottom/attendance_page.dart';
import 'package:soccermate/UI/groupHost_bottom/hostFirstBasic_page.dart';
import 'groupHost_bottom/dateVoting_page.dart';
import 'groupHost_bottom/notice_page.dart';




class GroupHostPage extends StatefulWidget {
  late int groupId;
  GroupHostPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }
  static const route = "/grouphostpage1";


  @override
  _GroupHostPageState createState() => _GroupHostPageState();

}

class _GroupHostPageState extends State<GroupHostPage> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget> [
      DateVotingPage(groupId: widget.groupId),       // -> index 0
      NoticePage(groupId: widget.groupId)    // -> index 1
      // -> index 3
    ];
    _widgetOptions.add(HostBasicPage(groupId: widget.groupId));
  }


  @override
  void dispose() {
    super.dispose();
  }

  int _selectedIndex = 2; // -> bottom navigator icon unselected
/*
  static const List<Widget> _widgetOptions = <Widget> [
    Text('Index 0: BasicPage'),
    Text('Index 1: 출석체크'),
    Text('Index 2: 날짜투표'),
    Text('Index 3: 게시글 작성'),
  ];
 */
  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;


    return SafeArea(
      top: false,
      bottom: false,
      maintainBottomViewPadding: false,
      minimum: EdgeInsets.only(bottom: 2),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.how_to_vote_outlined, size: 35,), label: '투표',),
            BottomNavigationBarItem(icon: Icon(Icons.note_alt_rounded, size: 35,), label: '게시판',),
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded, size: 35,), label: '홈',),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,

          selectedFontSize: 15,
          unselectedFontSize: 15,
          onTap: _onItemTapped,
        ),
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