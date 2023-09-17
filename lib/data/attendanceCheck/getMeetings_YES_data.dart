
class GetMeetings_YES {
  final List<int> attendance_meetings;


  GetMeetings_YES({
    required this.attendance_meetings });


  factory GetMeetings_YES.fromJson(Map<String, dynamic> json) {
    return GetMeetings_YES(
      attendance_meetings: new List<int>.from(json["attendance_meetings"]),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "attendance_meetins": this.attendance_meetings
    };
  }

}