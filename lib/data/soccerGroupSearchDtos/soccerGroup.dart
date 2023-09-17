
class SoccerGroup{
  late final String group_id;
  late final String group_name;
  late final String group_members_count;
  late final String group_profile_pict_path;
  late final String group_description;
  late final String group_region;
  late final String owner_id;
  late final List<int> members;

  SoccerGroup.fromJson(Map<String, dynamic> json) {
    this.group_id = json["group_id"].toString();
    this.group_name = json["group_name"].toString();
    this.group_members_count = json["group_member_count"].toString();
    this.group_profile_pict_path = json["group_profile_pict_path"].toString();
    this.group_description = json["group_description"].toString() ;
    this.group_region = json["group_region"].toString();
    this.owner_id = json["owner_id"].toString();
    this.members = new List<int>.from(json["members"]);

    print("done converting group with id " + group_id.toString());
  }
}