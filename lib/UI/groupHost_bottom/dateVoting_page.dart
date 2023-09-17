import 'package:flutter/material.dart';
import 'package:soccermate/UI/groupHost_bottom/voting_tab/scheduleList_page.dart';
import 'package:soccermate/UI/groupHost_bottom/voting_tab/votingList_page.dart';




class DateVotingPage extends StatefulWidget {
  late int groupId;
  DateVotingPage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }

  static const route = "/datevotingpage";

  @override
  _DateVotingPageState createState() => _DateVotingPageState();
}


class _DateVotingPageState extends State<DateVotingPage> with TickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  late TabController _tabController;
  String title = '투표 게시글';    // '모임 제목' 으로 변경 해야함


  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    _tabController.animateTo(1);
  }


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(130.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "netmarbleB"),
              ),
              centerTitle: true,
              leading: const BackButton(color: Colors.black),

              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black, width: 2))),
                tabs: [
                  /*
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text('진행 중인 투표', style: TextStyle(fontFamily: "netmarbleB", fontSize: 15)),
                  ),
                  */
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text('투표목록', style: TextStyle(fontFamily: "netmarbleB", fontSize: 15)),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text('일정목록', style: TextStyle(fontFamily: "netmarbleB", fontSize: 15)),
                  ),
                ],
              ),
            ),
          ),

          body: TabBarView(
            controller: _tabController,
            children: [
              VotingListPage(groupId: widget.groupId),
              ScheduleListPage(groupId: widget.groupId),
            ],

          )
        ),
      )
    );
  }




  Widget spacer(int flex) {
    return Flexible(
        flex: flex,
        child: Container()
    );
  }

}