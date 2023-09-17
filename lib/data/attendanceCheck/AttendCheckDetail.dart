import '../CreateMeeting/CreateMeetingDate.dart';
import '../CreateMeeting/CreateMeetingTime.dart';



class AttendCheckDetail{
  late final int meeting_id;
  late final String meeting_name;
  late final CreateMeetingDate meeting_date;
  late final String meeting_location;
  late final CreateMeetingTime meeting_time;
  late final String meeting_category;
  late final int group_id;

  late final double meeting_x_coordinate;
  late final double meeting_y_coordinate;
  late final List<int> joined_members;


  AttendCheckDetail.fromJson(Map<String, dynamic> json){
    this.meeting_id = json["meeting_id"] as int;
    this.meeting_name = json["meeting_name"].toString();
    this.meeting_date = CreateMeetingDate.fromJson(json["meeting_date"]);
    this.meeting_location = json["meeting_location"].toString();
    this.meeting_time = CreateMeetingTime.fromJson(json["meeting_time"]);
    this.meeting_category = json["meeting_category"].toString();
    this.group_id = json["group_id"] as int;

    this.meeting_x_coordinate = json["meeting_x_coordinate"] as double;
    this.meeting_y_coordinate = json["meeting_y_coordinate"] as double;

    this.joined_members = new List<int>.from(json["joined_members"]);


    print("done converting attendCheck_details");
  }
}