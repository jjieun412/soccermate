
import 'package:soccermate/data/voting/votingCategory_op.dart';
import 'package:soccermate/data/voting/votingDate_op.dart';
import 'package:soccermate/data/voting/votingLocation_op.dart';
import 'package:soccermate/data/voting/votingTime_op.dart';



class VotingItemsDetail {
  late final int vote_id;
  late final String created_time;
  late final String title;
  late final DateOption_List dates;
  late final LocationOption_List locations;
  late final TimeOption_List times;
  late final CategoryOption_List categories;



  VotingItemsDetail.fromJson(Map<String, dynamic> json){
    this.vote_id = json["vote_id"] as int;
    this.created_time = json["created_time"].toString();
    this.title = json["title"].toString();
    this.dates = DateOption_List.fromJson(json["dates"]);
    this.locations = LocationOption_List.fromJson(json["locations"]);
    this.times = TimeOption_List.fromJson(json["times"]);
    this.categories = CategoryOption_List.fromJson(json["categories"]);

    print("done converting votingItems_details");
  }

}

