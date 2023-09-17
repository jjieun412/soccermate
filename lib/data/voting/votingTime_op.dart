class detailTimes
{
  final int option_id;
  final int hour;
  final int minute;
  final List<int> vote_members;



  detailTimes({
        required this.option_id,
        required this.hour,
        required this.minute,
        required this.vote_members,
      });



  factory detailTimes.fromJson(Map<String, dynamic> json) {
    return detailTimes(
        option_id: int.parse(json["option_id"].toString()),
        hour: int.parse(json["hour"].toString()),
        minute: int.parse(json["minute"].toString()),
        vote_members: new List<int>.from(json["vote_members"])
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "option_id": this.option_id,
      "hour": this.hour,
      "minute": this.minute,
      "vote_members": this.vote_members
    };
  }
}


class TimeOption_List {
  late final List<detailTimes> timeOption_list;

  TimeOption_List.fromJson(List<dynamic> jsonList)
  {
    timeOption_list = [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList)
    {
      print("converting Times" + json.toString());
      timeOption_list.add(detailTimes.fromJson(json));
    }
  }
}
