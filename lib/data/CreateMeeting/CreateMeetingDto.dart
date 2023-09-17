import 'CreateMeetingDate.dart';
import 'CreateMeetingTime.dart';


class CreateMeetingDto {
  final String meeting_name;          // 모임 제목
  final CreateMeetingDate meeting_date;          // 모임 날짜
  final double meeting_x_coordinate;  //
  final double meeting_y_coordinate;  //
  final String meeting_location;      // 모임 장소
  final CreateMeetingTime meeting_time;          // 모임 시간
  final String meeting_category;      // 모임 종목 (풋살, 축구)



 CreateMeetingDto({
        required this.meeting_name,
        required this.meeting_date,
        required this.meeting_x_coordinate,
        required this.meeting_y_coordinate,
        required this.meeting_location,
        required this.meeting_time,
        required this.meeting_category });



  factory CreateMeetingDto.fromJson(Map<String, dynamic> json) {
    return CreateMeetingDto(
      meeting_name: json["meeting_name"],
      meeting_date: CreateMeetingDate.fromJson(json["meeting_date"]),
      meeting_x_coordinate: json["meeting_x_coordinate"],
      meeting_y_coordinate: json["meeting_y_coordinate"],
      meeting_location: json["meeting_location"],
      meeting_time: CreateMeetingTime.fromJson(json["meeting_time"]),
      meeting_category: json["meeting_category"],
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "meeting_name": this.meeting_name,
      "meeting_date": this.meeting_date.toJson(),
      "meeting_x_coordinate": this.meeting_x_coordinate,
      "meeting_y_coordinate": this.meeting_y_coordinate,
      "meeting_location": this.meeting_location,
      "meeting_time": this.meeting_time.toJson(),
      "meeting_category": this.meeting_category,
    };
  }
}