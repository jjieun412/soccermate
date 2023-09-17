
class CreateMeetingTime {
  final int hour;
  final int minute;



  CreateMeetingTime({
        required this.hour,
        required this.minute });



  factory CreateMeetingTime.fromJson(Map<String, dynamic> json) {
    return CreateMeetingTime(
        hour: int.parse(json["hour"].toString()),
        minute: int.parse(json["minute"].toString())
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "hour": this.hour,
      "minute": this.minute
    };
  }
}