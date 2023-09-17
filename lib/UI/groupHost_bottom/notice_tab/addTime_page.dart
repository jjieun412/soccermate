import 'package:flutter/material.dart';



class addTime extends StatefulWidget {
  addTime({Key? key}) : super(key: key){}

  static const route = "/addtimepage";

  @override
  _addTimeState createState() => _addTimeState();
}


class _addTimeState extends State<addTime> {
  final formKey = GlobalKey<FormState>();
  String? time1 = '';


  Widget _timeBtn() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.more_time, color: Colors.green, size: 30),
        label: Text('$time1', style: const TextStyle(color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
        onPressed: () async {
          TimeOfDay? newTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now());

          if(newTime != null) {
            setState(() {
              time1 = newTime.format(context);
            });
          }
        },
        style: ElevatedButton.styleFrom(
            elevation: 4,
            primary: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Center(
      child: _timeBtn(),
    );
  }

}