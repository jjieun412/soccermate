
class detailDates {
  late final int option_id;
  late final int year;
  late final int day;
  late final int month;
  late final List<int> vote_members;



  detailDates({
        required this.option_id,
        required this.year,
        required this.day,
        required this.month,
        required this.vote_members,
  });



  factory detailDates.fromJson(Map<String, dynamic> json) {
    return detailDates(
        option_id: int.parse(json["option_id"].toString()),
        year: int.parse(json["year"].toString()),
        day: int.parse(json["day"].toString()),
        month: int.parse(json["month"].toString()),
        vote_members: new List<int>.from(json["vote_members"])
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "option_id": this.option_id,
      "year": this.year,
      "day": this.day,
      "month": this.month,
      "vote_members": this.vote_members
    };
  }
}




class DateOption_List {
  late final List<detailDates> dateOption_list;

  DateOption_List.fromJson(List<dynamic> jsonList) {
    dateOption_list = [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList)
    {
      print("converting Dates" + json.toString());
      dateOption_list.add(detailDates.fromJson(json));
    }
  }
}

