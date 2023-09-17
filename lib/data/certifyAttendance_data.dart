

class CertifyAttend_Info {
  final double x_coordinate;
  final double y_coordinate;

  CertifyAttend_Info(
      {
        required this.x_coordinate,
        required this.y_coordinate
      });

  factory CertifyAttend_Info.fromJson(Map<String, dynamic> json) {
    return CertifyAttend_Info(
        x_coordinate: json["x_coordinate"] as double,
        y_coordinate: json["y_coordinate"] as double
    );
  }

  Map<String ,dynamic> toJson() {
    return {
      "x_coordinate": this.x_coordinate,
      "y_coordinate": this.y_coordinate
    };
  }
}