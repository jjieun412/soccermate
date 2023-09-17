
class CreatePostingDto {
  final String title;
  final String content;




  CreatePostingDto({
    required this.title,
    required this.content });



  factory CreatePostingDto.fromJson(Map<String, dynamic> json) {
    return CreatePostingDto(
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