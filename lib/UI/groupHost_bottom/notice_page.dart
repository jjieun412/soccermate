import 'package:flutter/material.dart';

import 'notice_tab/WritePost_page.dart';
import 'notice_tab/writeAttend_page.dart';
import 'notice_tab/writeVoting_page.dart';




class NoticePage extends StatefulWidget {
  late int groupId;
  NoticePage({required int groupId, Key? key}) : super(key: key){
    this.groupId = groupId;
  }

  static const route = "/noticepostingpage";

  @override
  _NoticePageState createState() => _NoticePageState();
}



class _NoticePageState extends State<NoticePage> {
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

    final double WidgetWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 1;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text('게시글', style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "netmarbleB"),),
            leading: const BackButton(color: Colors.black),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(color: Color(0xFFE9E9E9), height: 12),
            ),
          ),
        ),

        body: SafeArea(
          child: Container(
            height: WidgetHeight,
            width: WidgetWidth,
            color: Color(0xFFE9E9E9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const SizedBox(height: 50),
                const Text(
                  '게시글 유형을 선택해주세요.',
                  style: TextStyle(
                    color: Color(0xFF707070),
                    fontSize: 18,
                    fontFamily: "netmarbleM"
                  )
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WriteVotingPage(groupId: widget.groupId)));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: Colors.white,
                    padding: const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                  ),
                  child: const Text('투표', style: TextStyle(
                    color: Colors.black,
                    fontFamily: "netmarbleB",
                    fontSize: 22,
                  )),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WriteAttendPage(groupId: widget.groupId)));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.white,
                      padding: const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                  ),
                  child: const Text('참석', style: TextStyle(
                    color: Colors.black,
                    fontFamily: "netmarbleB",
                    fontSize: 22,
                  )),
                ),

                const SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () async {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => WritePostPage(groupId: widget.groupId)));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: Colors.white,
                      padding: const EdgeInsets.only(left: 60, right: 60, top: 20, bottom: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
                  ),
                  child: const Text('공지', style: TextStyle(
                    color: Colors.black,
                    fontFamily: "netmarbleB",
                    fontSize: 22,
                  )),
                ),

                const SizedBox(height: 100),

              ]
            ),
          )
        )
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