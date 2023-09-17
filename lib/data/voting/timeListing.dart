
import '../CreateMeeting/CreateMeetingTime.dart';



class Time_List {
  late final List<CreateMeetingTime> time_list;

  Time_List.fromJson(List< dynamic> jsonList){
    time_list = [];
    //List<dynamic> time_list_temp = jsonList["times"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList)
    {
      print("converting createTimes " + json.toString());
      time_list.add(CreateMeetingTime.fromJson(json));
    }
  }
}