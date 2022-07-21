class Bitrate {
  Bitrate({
    this.the2G,
    this.the3G,
    this.the4G,
  });

  int? the2G;
  int? the3G;
  int? the4G;

  factory Bitrate.fromJson(Map<String, dynamic> json) => Bitrate(
        the2G: json["2g"],
        the3G: json["3g"],
        the4G: json["4g"],
      );

  Map<String, dynamic> toJson() => {
        "2g": the2G,
        "3g": the3G,
        "4g": the4G,
      };
}

class BitratesMap {
  BitratesMap({
    this.name,
    this.code,
  });

  String? name;
  int? code;

  factory BitratesMap.fromJson(Map<String, dynamic> json) => BitratesMap(
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
      };
}
