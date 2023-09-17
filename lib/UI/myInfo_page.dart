import 'package:flutter/material.dart';
import 'package:soccermate/controller/user_controller.dart';
import 'package:soccermate/data/myInfo_data.dart';
import 'package:soccermate/repository/user_repository.dart';



class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);
  static const route = "/myinfopage";

  @override
  _MyInfoPageState createState() => _MyInfoPageState();
}



class _MyInfoPageState extends State<MyInfoPage> {
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

    final double WidgetsWidth = screenWidth * 0.8;
    final double WidgetHeight = screenHeight * 0.3;


    return Scaffold(
      resizeToAvoidBottomInset : false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            '마이 페이지',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: "netmarbleB"
            ),
          ),
          leading: const BackButton(
            color: Colors.grey,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),

            child: Container(
              color: Colors.grey,
              height: 1,
            ),
          ),
        ),
      ),
      body: Center(
        child:FutureBuilder<MyInfo>(
            future: _user_controller.myInfo() ,
            builder:(BuildContext context, AsyncSnapshot<MyInfo> snapshot){
              late MyInfo myInfo;
              if(snapshot!.hasData) {
                myInfo = snapshot!.data!;
                return buildContainer(WidgetHeight, WidgetsWidth, myInfo);
              }

              return CircularProgressIndicator();
            }
        )
      ),
    );
  }

  Container buildContainer(double WidgetHeight, double WidgetsWidth, MyInfo myInfo) {
    return Container(
        height: WidgetHeight,
        width: WidgetsWidth,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            spacer(2),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: Offset(2,2),
                  )
                ]
              ),
              //child: InfoEditBtnRow(),
              child: InfoViewRow(myInfo.profile, myInfo.nickname),
            ),

            spacer(1),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: Offset(2,2),
                    )
                  ]
              ),
              child: locationViewRow(myInfo.region),
            ),
            spacer(5),

          ],
        ),
      );
  }


  Flexible InfoViewRow(String imagePath, String nickname) {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          Flexible(
            flex: 10,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(imagePath),
                )
              ),
            )
          ),
          spacer(2),
          Flexible(
              flex: 10,
              child: Text(
                nickname,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: "netmarbleM",
                ),
              ),
            ),
          ],
      ),
    );
  }



  Flexible InfoEditBtnRow() {
    return Flexible(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 13,
            fit: FlexFit.tight,
            child: IconButton(
                onPressed: () async {

                },
                splashRadius: 100,
                iconSize: 30,
                icon: Icon(Icons.edit),

            ),
          ),
        ],
      ),
    );
  }


  Flexible locationViewRow(String location) {
    return Flexible(
      flex: 10,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget> [
          const Flexible(
            flex: 10,
            child: Icon(Icons.location_on, color: Colors.green, size: 20),
          ),
          spacer(1),
          Flexible(
            flex: 20,
            child: Text(
              location,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "netmarbleL",
              ),
            ),
          ),
          SizedBox(width: 50),
          const Flexible(
            flex: 10,
            child: Text(
              'local',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "netmarbleM",
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible NicknameRow() {
    return Flexible(
      flex: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 8,
            child: TextFormField(
              //controller: _loginemail,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: "netmarbleB",
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Flexible gotoMapBtnRow() {
    return Flexible(
      flex: 18,
      child: OutlinedButton(
        onPressed: () async {},
        style: OutlinedButton.styleFrom(
          primary: Colors.green,
          padding: const EdgeInsets.all(15.0),
        ),
        child: OutlinedButton.icon(
          onPressed: () async{},
          icon: const Icon(Icons.map_outlined, color: Colors.black),
          label: const Text(''),
        ),
      ),
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
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: const Color(0xFFF7F7F7),
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 30),
                  textStyle: const TextStyle(
                    color: Color(0xFF707070),
                    fontFamily: "netmarbleM",
                    fontSize: 14,
                  ),
                ),
                child: const Text('이전')
            ),
          ),
          spacer(2),
          Flexible(
            flex: 10,
            child: ElevatedButton(    // 다음 버튼
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  primary: Colors.green,
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