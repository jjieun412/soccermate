



import '../CreateMeeting/CreateMeetingDate.dart';
import '../CreateMeeting/CreateMeetingTime.dart';



class CreateVotingDto {
  final List<String> categories;
  final List<String> locations;
  final List<CreateMeetingTime> times;
  final List<CreateMeetingDate> dates;
  final String title;



  CreateVotingDto({
    required this.categories,
    required this.locations,
    required this.times,
    required this.dates,
    required this.title  });



  factory CreateVotingDto.fromJson(Map<String, dynamic> json) {
    return CreateVotingDto(
      categories: json["categories"],
      locations: json["locations"],
      times: json["times"],
      dates: json["dates"],
      title: json["title"],
    );
  }


  Map<String ,dynamic> toJson() {
    return {
      "categories": this.categories,
      "locations": this.locations,
      "times": this.times,
      "dates": this.dates,
      "title": this.title,
    };
  }
}