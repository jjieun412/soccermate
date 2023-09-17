import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart';
import 'package:soccermate/UI/setInfo2_page.dart';
import 'package:soccermate/repository/user_repository.dart';


class SetInfo1Page extends StatefulWidget {
  const SetInfo1Page({Key? key}) : super(key: key);
  static const route = "/setinfo1page";

  @override
  _SetInfo1PageState createState() => _SetInfo1PageState();
}


class _SetInfo1PageState extends State<SetInfo1Page> {
  final formKey = GlobalKey<FormState>();
  late double lat = 0.0;
  late double lng = 0.0;
  late String _currentAddress = " ";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  // 내 위치 받아오기 (위도, 경도)
  Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);   // Latitude: ---, Longitude: ---
    lat = position.latitude;
    lng = position.longitude;

    final String GOOGLE_API_KEY = 'AIzaSyAllB79K-OXtdoaumBYwbCx7Db6eRK-3NE';
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY&language=ko';

    Response response = await http.get(Uri.parse(url));

    String region = jsonDecode(response.body)['results'][0]['formatted_address'];
    print(region);

    final temp = region.split(' ');
    String location = temp[1] + " " + temp[2];
    _currentAddress = location;
    print(_currentAddress);
  }






  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double WidgetsWidth = screenWidth * 1;
    final double WidgetHeight = screenHeight * 0.8;


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
      body: Container(
          height: WidgetHeight,
          width: WidgetsWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              spacer(1),

              Image.asset('images/setinfo_icons.png', scale: 1),

              spacer(1),
              text1Row(),
              spacer(1),

              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey, width: 1),),
                ),
              ),

              spacer(4),


              text2Row(),   // 지역 선택해주세요
              spacer(3),

              Container(    // 내 위치 설정 버튼
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xFF3ABB3E), width: 1),
                ),
                child: getLocationBtnRow(),  // 지도모양 버튼 -> 현위치 표시되며 지도 알림
              ),

              spacer(3),
              text3Row(),
              spacer(5),


              movePageBtnRow(),
              spacer(3),

            ],
          ),
        ),
      )
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
              '지역을 설정해주세요.',
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


  Flexible text3Row() {
    return Flexible(
      flex: 12,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _currentAddress,
            style: TextStyle(
              fontSize: 11,
              fontFamily: "netmarbleM",
            ),
          ),
        ],
      )
    );
  }


  Flexible getLocationBtnRow() {
    return Flexible(
      flex: 18,
      child: OutlinedButton(
              onPressed: () async {
                await getLocation();
                setState(() {
                });
                //getDetailLocation(lat, lng);
              },
              style: OutlinedButton.styleFrom(
                primary: Color(0xFF3ABB3E),
                padding: const EdgeInsets.all(20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(color: Color(0xFF3ABB3E), width: 1),
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
                  Navigator.pushNamed(
                      context,
                      SetInfo2Page.route,
                      arguments: _currentAddress);
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


