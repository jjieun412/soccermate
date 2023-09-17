class CreateMeetingDate {
  final int year;
  final int month;
  final int day;



  CreateMeetingDate({
        required this.year,
        required this.month,
        required this.day });



  factory CreateMeetingDate.fromJson(Map<String, dynamic> json) {
    return CreateMeetingDate(
      year: int.parse(json["year"].toString()),
      month: int.parse(json["month"].toString()),
      day: int.parse(json["day"].toString())
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "year": this.year,
      "month": this.month,
      "day": this.day
    };
  }
}