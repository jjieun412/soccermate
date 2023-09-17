
class VotingItems{
  late final String title;
  late final int vote_id;
  late final String created_time;


  VotingItems.fromJson(Map<String, dynamic> json){
    this.vote_id = int.parse(json["vote_id"].toString());
    this.title = json["title"].toString();
    this.created_time = json["created_time"].toString();

    print("done converting votingItems");
  }
}