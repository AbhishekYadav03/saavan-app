import 'package:saavan_app/models/chart_more_info.dart';

class Chart {
  Chart({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.image,
    this.permaUrl,
    this.moreInfo,
    this.explicitContent,
    this.miniObj = true,
    this.language,
  });

  String? id;
  String? title;
  String? subtitle;
  String? type;
  String? image;
  String? permaUrl;
  ChartMoreInfo? moreInfo;
  String? explicitContent;
  bool miniObj;
  String? language;

  factory Chart.fromJson(Map<String, dynamic> json) => Chart(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: ChartMoreInfo.fromJson(json["more_info"]),
        explicitContent: json["explicit_content"],
        miniObj: json["mini_obj"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "type": type,
        "image": image,
        "perma_url": permaUrl,
        "more_info": moreInfo?.toJson(),
        "explicit_content": explicitContent,
        "mini_obj": miniObj,
        "language": language,
      };
}
