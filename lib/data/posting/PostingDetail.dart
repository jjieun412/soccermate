import '../CreateMeeting/CreateMeetingDate.dart';
import '../CreateMeeting/CreateMeetingTime.dart';



class PostingDetail {
  late final int announcement_id;
  late final String announcement_title;
  late final String created_time;
  late final int writer_id;
  late final int group_id;
  late final String content;


  PostingDetail.fromJson(Map<String, dynamic> json){
    this.announcement_id = json["announcement_id"] as int;
    this.announcement_title = json["announcement_title"].toString();
    this.created_time = json["created_time"].toString();
    this.writer_id = json["writer_id"] as int;
    this.group_id = json["group_id"] as int;
    this.content = json["content"].toString();

    print("done converting posting_details");
  }
}