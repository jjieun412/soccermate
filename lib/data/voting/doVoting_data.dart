
class DoVoting_Info {
  final int date_option_id;
  final int times_option_id;
  final int location_option_id;
  final int category_option_id;



  DoVoting_Info({
        required this.date_option_id,
        required this.times_option_id,
        required this.location_option_id,
        required this.category_option_id });



  factory DoVoting_Info.fromJson(Map<String, dynamic> json) {
    return DoVoting_Info(
      date_option_id: json["date_option_id"],
      times_option_id: json["times_option_id"],
      location_option_id: json["location_option_id"],
      category_option_id: json["category_option_id"],
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "date_option_id": this.date_option_id,
      "times_option_id": this.times_option_id,
      "location_option_id": this.location_option_id,
      "category_option_id": this.category_option_id,
    };
  }
}