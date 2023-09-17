import 'package:flutter/material.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/data/posting/PostingDetail.dart';



class DetailPostPage extends StatefulWidget {
  late final int groupId;
  late final int announceId;
  DetailPostPage({required int groupId, required int announceId, Key? key}) : super(key: key) {
    this.groupId = groupId;
    this.announceId = announceId;
  }
  static const route = "/detailpostpage";

  @override
  _DetailPostPageState createState() => _DetailPostPageState();
}


class _DetailPostPageState extends State<DetailPostPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;


  @override
  void initState() {
    _user_controller = User_Controller();
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
              title: const Text(
                '공지 게시판',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: "netmarbleB"),
              ),
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
                  color: Colors.white,
                  child: FutureBuilder<PostingDetail>(
                    future: _user_controller.detailPosting(groupId: widget.groupId, announcementId: widget.announceId),
                    builder: (BuildContext context, AsyncSnapshot<PostingDetail> snapshot) {
                      if (snapshot.hasData) {
                      print("snapshot has PostingDetail data!");
                      PostingDetail getDetailPost = snapshot.data!;

                        return Container(
                              width: WidgetWidth,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20, left: 35, right: 35, bottom: 20),
                                child:Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 20),
                                    //Text('작성일 :     ${getDetailPost.created_time.substring(0,4)}년 ${getDetailPost.created_time.substring(5,7)}월 ${getDetailPost.created_time.substring(8,10)}일', style: TextStyle(fontSize: 12, fontFamily: "netmarbleL", color: Colors.black)),
                                    //SizedBox(height: 20),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset('images/postalarm.png', scale: 3),
                                        SizedBox(width: 30),
                                        Text(getDetailPost.announcement_title, style: TextStyle(fontSize: 20, fontFamily: "netmarbleB"))
                                      ],
                                    ),

                                    SizedBox(height: 40),
                                    Text('   ${getDetailPost.content}', style: TextStyle(fontSize: 14, fontFamily: "netmarbleM", color: Colors.black)),
                                  ]
                                )
                              )
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      }
                  ),
              )
          ),
      )
    );
  }




}