
class Detail_Posting_Info {
  final int announcement_id;
  final String announcement_title;
  final String created_time;
  final int writer_id;
  final int group_id;
  final String content;


  Detail_Posting_Info({
    required this.announcement_id,
    required this.announcement_title,
    required this.created_time,
    required this.writer_id,
    required this.group_id,
    required this.content });


  factory Detail_Posting_Info.fromJson(Map<String, dynamic> json) {
    return Detail_Posting_Info(
      announcement_id: int.parse(json["announcement_id"].toString()),
      announcement_title: json["announcement_title"].toString(),
      created_time: json["created_time"].toString(),
      writer_id: int.parse(json["writer_id"].toString()),
      group_id: int.parse(json["group_id"].toString()),
      content: json["content"].toString(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      "announcement_id": this.announcement_id,
      "announcement_title": this.announcement_title,
      "created_time": this.created_time,
      "writer_id": this.writer_id,
      "group_id": this.group_id,
      "content": this.content,
    };
  }
}


