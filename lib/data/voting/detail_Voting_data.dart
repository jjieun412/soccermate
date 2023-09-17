import 'package:soccermate/data/voting/votingCategory_op.dart';
import 'package:soccermate/data/voting/votingDate_op.dart';
import 'package:soccermate/data/voting/votingLocation_op.dart';
import 'package:soccermate/data/voting/votingTime_op.dart';



class Detail_VotingItems_Info {
  final int vote_id;
  final String created_time;
  final String title;
  final List<detailDates> dates;
  final List<detailLocations> locations;
  final List<detailTimes> times;
  final List<detailCategories> categories;



  Detail_VotingItems_Info({
        required this.vote_id,
        required this.created_time,
        required this.title,
        required this.dates,
        required this.locations,
        required this.times,
        required this.categories });



  factory Detail_VotingItems_Info.fromJson(Map<String, dynamic> json) {
    return Detail_VotingItems_Info(
      vote_id: int.parse(json["vote_id"].toString()),
      created_time: json["created_time"].toString(),
      title: json["title"].toString(),
      dates: (json["dates"] as List).map((dateList) => detailDates.fromJson(dateList)).toList(),
      locations: (json["locations"] as List).map((locationList) => detailLocations.fromJson(locationList)).toList(),
      times: (json["times"]).map((timeList) => detailTimes.fromJson(timeList)).toList(),
      categories: (json["categories"]).map((dateList) => detailCategories.fromJson(dateList)).toList(),
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "vote_id": this.vote_id,
      "created_time": this.created_time,
      "title": this.title,
      "dates": this.dates,
      "locations": this.locations,
      "times": this.times,
      "categories": this.categories,
    };
  }


}