
import '../CreateMeeting/CreateMeetingDate.dart';



class Date_List {
  late final List<CreateMeetingDate> date_list;

  Date_List.fromJson(List<dynamic> jsonList){
    date_list = [];
    //List<dynamic> date_list_temp = jsonList["dates"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList) {
      print("converting createDates" + json.toString());
      date_list.add(CreateMeetingDate.fromJson(json));
    }
  }
}