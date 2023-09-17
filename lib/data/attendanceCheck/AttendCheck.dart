
class AttendCheck{
  late final int meeting_id;
  late final String meeting_name;
  late final String meeting_date;
  late final String meeting_location;
  late final String meeting_time;
  late final String meeting_category;
  late final int group_id;
  late final String meeting_title;


  AttendCheck.fromJson(Map<String, dynamic> json){
    this.meeting_id = int.parse(json["meeting_id"].toString());
    this.meeting_name = json["meeting_name"].toString();
    this.meeting_date = json["meeting_date"];
    this.meeting_location = json["meeting_location"].toString();
    this.meeting_time = json["meeting_time"];
    this.meeting_category = json["meeting_category"].toString();
    this.group_id = int.parse(json["group_id"].toString());

    this.meeting_title = json["meeting_title"].toString();


    print("done converting attendChecks");
  }
}