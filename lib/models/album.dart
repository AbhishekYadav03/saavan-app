import 'dart:convert';

import 'package:git_app/models/album_more_info.dart';

List<Album> albumsFromJson(String str) => List<Album>.from(json.decode(str).map((x) => Album.fromJson(x)));

String albumsToJson(List<Album> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Album {
  Album({
    this.id,
    this.title,
    this.subtitle,
    this.headerDesc,
    this.type,
    this.permaUrl,
    this.image,
    this.language,
    this.year,
    this.playCount,
    this.explicitContent,
    this.listCount,
    this.listType,
    this.list,
    this.moreInfo,
  });

  String? id;
  String? title;
  String? subtitle;
  String? headerDesc;
  String? type;
  String? permaUrl;
  String? image;
  String? language;
  String? year;
  String? playCount;
  String? explicitContent;
  String? listCount;
  String? listType;
  String? list;
  AlbumMoreInfo? moreInfo;

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        headerDesc: json["header_desc"],
        type: json["type"],
        permaUrl: json["perma_url"],
        image: json["image"],
        language: json["language"],
        year: json["year"],
        playCount: json["play_count"],
        explicitContent: json["explicit_content"],
        listCount: json["list_count"],
        listType: json["list_type"],
        list: json["list"],
        moreInfo: json["more_info"] != null ? AlbumMoreInfo.fromJson(json["more_info"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "header_desc": headerDesc,
        "type": type,
        "perma_url": permaUrl,
        "image": image,
        "language": language,
        "year": year,
        "play_count": playCount,
        "explicit_content": explicitContent,
        "list_count": listCount,
        "list_type": listType,
        "list": list,
        "more_info": moreInfo?.toJson(),
      };
}
