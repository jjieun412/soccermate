
class Posting {
  late final int announcement_id;
  late final String announcement_title;
  late final String created_time;
  late final int writer_id;
  late final int group_id;


  Posting.fromJson(Map<String, dynamic> json){
    this.announcement_id = int.parse(json["announcement_id"].toString());
    this.announcement_title = json["announcement_title"].toString();
    this.created_time = json["created_time"];
    this.writer_id = int.parse(json["writer_id"].toString());
    this.group_id = int.parse(json["group_id"].toString());

    print("done converting postings");
  }
}