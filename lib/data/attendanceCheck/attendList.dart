import 'package:soccermate/data/attendanceCheck/AttendCheck.dart';



class AttendList_Info {
  late final List<AttendCheck> attend_list;

  AttendList_Info.fromJson(Map<String, dynamic> jsonList){
    attend_list = [];
    List<dynamic> attend_list_temp = jsonList["meetings"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in attend_list_temp) {
      print("converting attendList " + json.toString());
      attend_list.add(AttendCheck.fromJson(json));
    }
  }
}
