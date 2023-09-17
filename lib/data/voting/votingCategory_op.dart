class detailCategories
{
  final int option_id;
  final String category_name;
  final List<int> vote_members;



  detailCategories({
        required this.option_id,
        required this.category_name,
        required this.vote_members,
  });



  factory detailCategories.fromJson(Map<String, dynamic> json) {
    return detailCategories(
        option_id: int.parse(json["option_id"].toString()),
        category_name: json["category_name"],
        vote_members: new List<int>.from(json["vote_members"])
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "option_id": this.option_id,
      "category_name": this.category_name,
      "vote_members": this.vote_members
    };
  }
}


class CategoryOption_List {
  late final List<detailCategories> categoryOption_list;

  CategoryOption_List.fromJson(List<dynamic> jsonList){
    categoryOption_list = [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList)
    {
      print("converting " + json.toString());
      categoryOption_list.add(detailCategories.fromJson(json));
    }
  }
}