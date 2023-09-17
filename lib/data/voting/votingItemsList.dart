import 'VotingItems.dart';



class VotingItemsList_Info {
  late final List<VotingItems> votingItem_list;

  VotingItemsList_Info.fromJson(Map<String, dynamic> jsonList){
    votingItem_list = [];
    List<dynamic> votingItem_list_temp = jsonList["votes"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in votingItem_list_temp) {
      print("converting votingItemsList " + json.toString());
      votingItem_list.add(VotingItems.fromJson(json));
    }
  }
}