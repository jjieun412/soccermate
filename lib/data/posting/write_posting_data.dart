
class Write_Posting_Info {
  final String title;
  final String content;




  Write_Posting_Info({
    required this.title,
    required this.content });



  factory Write_Posting_Info.fromJson(Map<String, dynamic> json) {
    return Write_Posting_Info(
      title: json["title"],
      content: json["content"],
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "title": this.title,
      "content": this.content,
    };
  }
}