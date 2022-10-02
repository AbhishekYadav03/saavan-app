class ShowMoreInfo {
  ShowMoreInfo({
    this.seasonNumber,
  });

  int? seasonNumber;

  factory ShowMoreInfo.fromJson(Map<String, dynamic> json) => ShowMoreInfo(
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "season_number": seasonNumber,
      };
}
