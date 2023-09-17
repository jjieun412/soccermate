
class detailLocations
{
  final int option_id;
  final String location_name;
  final List<int> vote_members;



  detailLocations({
        required this.option_id,
        required this.location_name,
        required this.vote_members,
  });



  factory detailLocations.fromJson(Map<String, dynamic> json) {
    return detailLocations(
        option_id: int.parse(json["option_id"].toString()),
        location_name: json["location_name"],
        vote_members: new List<int>.from(json["vote_members"])
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "option_id": this.option_id,
      "location_name": this.location_name,
      "vote_members": this.vote_members
    };
  }
}


class LocationOption_List {
  late final List<detailLocations> locationOption_list;

  LocationOption_List.fromJson(List<dynamic> jsonList) {
    locationOption_list = [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in jsonList) {
      print("converting Locations " + json.toString());
      locationOption_list.add(detailLocations.fromJson(json));
    }
  }
}