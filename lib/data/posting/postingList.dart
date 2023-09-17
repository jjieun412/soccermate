import 'Posting.dart';



class PostList_Info {
  late final List<Posting> post_list;

  PostList_Info.fromJson(Map<String, dynamic> jsonList){
    post_list = [];
    List<dynamic> post_list_temp = jsonList["announcements"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in post_list_temp) {
      print("converting postList " + json.toString());
      post_list.add(Posting.fromJson(json));
    }
  }
}