import 'package:flutter/material.dart';



class addLocation extends StatefulWidget {
  late String groupLocation;
  addLocation({Key? key}) : super(key: key){

  }

  static const route = "/addlocationpage";

  @override
  _addLocationState createState() => _addLocationState();
}


class _addLocationState extends State<addLocation> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _locationcontroller;


  @override
  void initState() {
    _locationcontroller = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _locationcontroller.dispose();
    super.dispose();
  }


  Widget _locationRow(String groupLocation) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 220),
      child: TextFormField(
        controller: _locationcontroller,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
          fontFamily: "netmarbleB",
        ),
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: '장소 입력',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF707070), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF707070), width: 1),
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Center(
      child: _locationRow(_locationcontroller.text),
    );
  }

}