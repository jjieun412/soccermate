import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soccermate/UI/dto/setInfo_data.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/repository/user_repository.dart';

import 'home_page.dart';


class SetInfo3Page extends StatefulWidget {
  const SetInfo3Page({Key? key}) : super(key: key);
  static const route = "/setinfo3page";

  @override
  _SetInfo3PageState createState() => _SetInfo3PageState();

}

class _SetInfo3PageState extends State<SetInfo3Page> {
  final formKey = GlobalKey<FormState>();
  late final double maxImageWidth;
  late final double maxImageHeight;
  XFile? _image;
  late SetInfoArguments infos;
  late User_Controller _user_controller;




  _getImage(ImageSource src) async {
    print("get image called!");
    XFile? img = await ImagePicker().pickImage(source: src);
    _image = img!;

    print(_image);
    print("get image ended!");

    setState(() {
    });
  }


  Widget _setImage(){
    print("setImage callled!");
    if(_image == null) {

      print("_image is null!");
      return const Icon(Icons.camera_alt);
    } else {
      print(_image!.path);
      return Image.file(File(_image!.path), fit: BoxFit.fill,);//, fit: BoxFit.fill
    }
  }


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

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.8;

    // 설정 지역,닉네임 데이터 가져오기
    infos = ModalRoute.of(context)!.settings.arguments as SetInfoArguments;
    print(infos);  // 지역, 닉네임 데이터


    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            '유저 정보 설정',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "netmarbleB"
            ),
          ),
          leading: const BackButton(color: Colors.grey),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.grey,
              height: 1,
            ),
          ),
        ),
      ),
      body: Container(
          height: WidgetHeight,
          width: WidgetsWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              spacer(1),

              Image.asset('images/setinfo_icons.png', scale: 1),

              spacer(2),
              text1Row(),
              spacer(3),

              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 1),),
                ),
              ),
              spacer(5),

              text2Row(),   // 프로필 사진 설정해주세요
              spacer(5),
              Container(    // 프로필 설정 버튼
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF3ABB3E), width: 1),
                ),
                child: profileBtnRow(),
              ),
              spacer(10),

              movePageBtnRow(),
              spacer(3),

            ],
          ),
        ),
      );

  }


  Flexible text1Row() {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Flexible(
            flex: 10,
            child: Text(
              '입력해주시는 정보 설정에 따라\n 회원님에게 맞는 메이트 그룹을 찾는데 도움을 드리고자 합니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: "netmarbleM"
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible text2Row() {
    return Flexible(
      flex: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Flexible(
            flex: 10,
            child: Text(
              '프로필 사진을 설정해주세요.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: "netmarbleB",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget profileBtnRow1() {
    return GestureDetector(
      child:_setImage() ,
      onTap: () async{
        //await _getImage();
      }
    );
  }

  Widget profileBtnRow() {
    return GestureDetector(
          child:_setImage() ,
          onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return SimpleDialog(
                  title: const Text('프로필 설정하기'),
                  children: <Widget>[
                    SimpleDialogOption(   // 카메라
                        onPressed: () {
                          _getImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.camera_alt),
                            Text('  카메라로 촬영하기'),
                          ],
                        )
                    ),
                    SimpleDialogOption(   // 갤러리
                        onPressed: () async {
                          await _getImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                          setState(() {
                            print("set_state called!");
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.image),
                            Text('  갤러리에서 가져오기'),
                          ],
                        )
                    ),
                  ]
              );
            }
          );
        },
      );
  }


  Flexible movePageBtnRow() {
    return Flexible(
      flex: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 10,
            child: ElevatedButton(   // 이전 버튼
                onPressed: () async {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFF7F7F7),
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                ),
                child: const Text(
                  '이전',
                  style: TextStyle(
                    color: Color(0xFFA3A3A3),
                    fontFamily: "netmarbleM",
                    fontSize: 14,
                  ),
                )
            ),
          ),
          spacer(2),
          Flexible(
            flex: 10,
            child: ElevatedButton(    // 다음 버튼
                onPressed: () async {

                 bool result = await _user_controller.setInfo(nickname: infos.nickname, region: infos.location, picture:_image!.path);
                 if (result = true) {  Navigator.pushNamed(context, HomePage.route ); }
                 else {

                 }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Color(0xFF3ABB3E),
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontFamily: "netmarbleM",
                    fontSize: 14,
                  ),
                ),
                child: const Text('다음')
            ),
          )
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