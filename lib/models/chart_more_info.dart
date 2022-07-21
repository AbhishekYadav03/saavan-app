class ChartMoreInfo {
  ChartMoreInfo({
    this.firstname,
  });

  String? firstname;

  factory ChartMoreInfo.fromJson(Map<String, dynamic> json) => ChartMoreInfo(
        firstname: json["firstname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
      };
}
