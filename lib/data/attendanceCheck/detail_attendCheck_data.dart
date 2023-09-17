import '../CreateMeeting/CreateMeetingDate.dart';
import '../CreateMeeting/CreateMeetingTime.dart';



class Detail_AttendCheck_Info {
  final int group_id;
  final int meeting_id;
  final String meeting_name;          // 모임 제목
  final CreateMeetingDate meeting_date;          // 모임 날짜
  final double meeting_x_coordinate;  //
  final double meeting_y_coordinate;  //
  final String meeting_location;      // 모임 장소
  final CreateMeetingTime meeting_time;          // 모임 시간
  final String meeting_category;      // 모임 종목 (풋살, 축구)
  final List<int> joined_members;



  Detail_AttendCheck_Info({
        required this.group_id,
        required this.meeting_id,
        required this.meeting_name,
        required this.meeting_date,
        required this.meeting_x_coordinate,
        required this.meeting_y_coordinate,
        required this.meeting_location,
        required this.meeting_time,
        required this.meeting_category,
        required this.joined_members });



  factory Detail_AttendCheck_Info.fromJson(Map<String, dynamic> json) {
    return Detail_AttendCheck_Info(
      group_id: int.parse(json["group_id"].toString()),
      meeting_id: int.parse(json["meeting_id"].toString()),
      meeting_name: json["meeting_name"].toString(),
      meeting_date: CreateMeetingDate.fromJson(json["meeting_date"]),
      meeting_x_coordinate: double.parse(json["meeting_x_coordinate"]),
      meeting_y_coordinate: double.parse(json["meeting_y_coordinate"]),
      meeting_location: json["meeting_location"].toString(),
      meeting_time: CreateMeetingTime.fromJson(json["meeting_time"]),
      meeting_category: json["meeting_category"].toString(),
      joined_members: new List<int>.from(json["joined_members"]),
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "group_id": this.group_id,
      "meeting_id": this.meeting_id,
      "meeting_name": this.meeting_name,
      "meeting_date": this.meeting_date.toJson(),
      "meeting_x_coordinate": this.meeting_x_coordinate,
      "meeting_y_coordinate": this.meeting_y_coordinate,
      "meeting_location": this.meeting_location,
      "meeting_time": this.meeting_time.toJson(),
      "meeting_category": this.meeting_category,
      "joined_members": this.joined_members,
    };
  }


}