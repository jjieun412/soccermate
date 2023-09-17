import 'package:flutter/material.dart';



class addDate extends StatefulWidget {
  DateTime? setDate;
  addDate({Key? key}) : super(key: key){
    //this.setDate = setDate;
  }

  static const route = "/adddatepage";

  @override
  _addDateState createState() => _addDateState();
}


class _addDateState extends State<addDate> {
  final formKey = GlobalKey<FormState>();

  late DateTime date1 = DateTime.now();
  String? temp = '';



  Widget _dateBtn() {
    //late DateTime dateTime = DateTime.now();
    //String? temp ='';
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 200),
      child: ElevatedButton.icon(
        icon: const Icon(Icons.calendar_month, color: Colors.green, size: 30),
        label: Text('${date1.year}. ${date1.month}. ${date1.day}',
            style: const TextStyle(
                color: Colors.black, fontFamily: "netmarbleB", fontSize: 14)),
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2030),
          );

          if (newDate == null) return;

          setState(() {
            date1 = newDate;
          });
        },
        style: ElevatedButton.styleFrom(
            elevation: 5,
            primary: Colors.white,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14))
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return Center(
      child: _dateBtn(),
    );
  }

}
