import 'package:flutter/material.dart';
import 'package:soccermate/UI/groupHost_page.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/data/posting/CreatePostingDto.dart';
import 'package:soccermate/data/posting/write_posting_data.dart';




class WritePostPage extends StatefulWidget {
  late final int groupId;
  WritePostPage({required int groupId, Key? key}) : super(key: key) {
    this.groupId = groupId;
  }
  static const route = "/writepostpage";

  @override
  _WritePostPageState createState() => _WritePostPageState();
}


class _WritePostPageState extends State<WritePostPage> {
  final formKey = GlobalKey<FormState>();
  late User_Controller _user_controller;
  late TextEditingController _contentcontroller;
  late TextEditingController _titlecontroller;



  @override
  void initState() {
    _user_controller = User_Controller();
    _titlecontroller = TextEditingController(text: "");
    _contentcontroller = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _contentcontroller.dispose();
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
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                '공지 게시글',
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
                  color: Color(0xFFE9E9E9),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Container(
                            width: WidgetWidth,
                            padding: EdgeInsets.all(50),
                            decoration: BoxDecoration(color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                              SizedBox(height: 20),

                              const Text(
                                '1. 제목을 입력해주세요.',
                                style: TextStyle(color: Colors.black, fontSize: 14,  fontFamily: "netmarbleM")
                              ),

                                SizedBox(height: 12),

                                ConstrainedBox(
                                  constraints: const BoxConstraints.tightFor(width: 300),
                                  child: TextFormField(
                                    controller: _titlecontroller,
                                    style: const TextStyle(color: Colors.black, fontSize: 13, fontFamily: "netmarbleB"),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: '제목 입력',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                                      )
                                    ),
                                  ),
                                ),

                                SizedBox(height: 40),

                                const Text(
                                    '2. 공지할 내용을 작성해주세요.',
                                    style: TextStyle(color: Colors.black, fontSize: 14, fontFamily: "netmarbleM")
                                ),

                                SizedBox(height: 12),

                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 300, minHeight: 200),
                                  child: TextFormField(
                                    controller: _contentcontroller,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 10,
                                    style: const TextStyle(color: Colors.black, fontSize: 13, fontFamily: "netmarbleB"),
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: '내용을 입력해 주세요.',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Color(0xFF707070), width: 1),
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 30),


                          // 공지 게시글 생성 버튼
                          ElevatedButton(
                            onPressed: () async {


                              CreatePostingDto createPostingDto = CreatePostingDto(title: _titlecontroller.text, content: _contentcontroller.text);
                              print('write posting request body');
                              print(createPostingDto);

                              _user_controller.writePosting(groupId: widget.groupId, createPostingDto: createPostingDto);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupHostPage(groupId: widget.groupId)));
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              padding: const EdgeInsets.only(left: 100, right: 100, top: 15, bottom: 15),
                            ),
                            child: const Text('공지 게시하기', style: TextStyle(color: Colors.white, fontFamily: "netmarbleB", fontSize: 14,)),
                          ),

                          const SizedBox(height: 50),

                        ]
                    ),
                  )

              )
          )
        )
    );
  }
}