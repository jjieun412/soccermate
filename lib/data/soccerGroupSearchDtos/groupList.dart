import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:soccermate/data/soccerGroupSearchDtos/soccerGroup.dart';


class GroupList_Info {
  late final List<SoccerGroup>soccer_group_list;

  GroupList_Info.fromJson(Map<String, dynamic> jsonList)
  {
    soccer_group_list = [];
    List<dynamic> soccer_group_list_temp = jsonList["soccer_group_list"]?? [];

    print("about to go into the loop");
    for(Map<String, dynamic> json in soccer_group_list_temp)
    {
      print("converting " + json.toString());
      soccer_group_list.add(SoccerGroup.fromJson(json));
    }
  }

}