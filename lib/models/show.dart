import 'package:saavan_app/models/show_more_info.dart';

class Show {
  Show({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.image,
    this.permaUrl,
    this.moreInfo,
    this.explicitContent,
    this.miniObj,
    this.description,
  });

  String? id;
  String? title;
  String? subtitle;
  String? type;
  String? image;
  String? permaUrl;
  ShowMoreInfo? moreInfo;
  String? explicitContent;
  bool? miniObj;
  String? description;

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: ShowMoreInfo.fromJson(json["more_info"]),
        explicitContent: json["explicit_content"],
        miniObj: json["mini_obj"],
        description: json["description"],
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
        "description": description,
      };
}
