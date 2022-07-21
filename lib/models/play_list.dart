import 'package:git_app/models/play_list_more_info.dart';

class PlaylistInfo {
  PlaylistInfo({
    this.id,
    this.title,
    this.subtitle,
    this.type,
    this.image,
    this.permaUrl,
    this.moreInfo,
    this.explicitContent,
    this.miniObj = true,
  });

  String? id;
  String? title;
  String? subtitle;
  String? type;
  String? image;
  String? permaUrl;
  PlaylistMoreInfo? moreInfo;
  String? explicitContent;
  bool miniObj;

  factory PlaylistInfo.fromJson(Map<String, dynamic> json) => PlaylistInfo(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: json["more_info"] != null ? PlaylistMoreInfo.fromJson(json["more_info"]) : null,
        explicitContent: json["explicit_content"],
        miniObj: json["mini_obj"],
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
      };
}
