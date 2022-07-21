// To parse this JSON data, do
//
//     final homeData = homeDataFromJson(jsonString);

import 'dart:convert';

import 'package:git_app/models/album.dart';
import 'package:git_app/models/chart.dart';
import 'package:git_app/models/genre.dart';
import 'package:git_app/models/globle_config.dart';
import 'package:git_app/models/play_list.dart';
import 'package:git_app/models/user_state.dart';

HomeData homeDataFromJson(String str) => HomeData.fromJson(json.decode(str));

String homeDataToJson(HomeData data) => json.encode(data.toJson());

class HomeData {
  HomeData({
    this.albums,
    this.featuredPlaylists,
    this.userState,
    this.globalConfig,
    this.charts,
    this.genres,
  });

  List<Album>? albums;
  List<PlaylistInfo>? featuredPlaylists;
  UserState? userState;
  GlobalConfig? globalConfig;
  List<Chart>? charts;
  List<Genre>? genres;

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        albums: List<Album>.from(json["new_albums"].map((x) => Album.fromJson(x))),
        featuredPlaylists:
            List<PlaylistInfo>.from(json["featured_playlists"].map((x) => PlaylistInfo.fromJson(x))),
        userState: UserState.fromJson(json["user_state"]),
        globalConfig: GlobalConfig.fromJson(json["global_config"]),
        charts: List<Chart>.from(json["charts"].map((x) => Chart.fromJson(x))),
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "new_albums": albums != null ? List<dynamic>.from(albums!.map((x) => x.toJson())) : null,
        "featured_playlists":
            featuredPlaylists != null ? List<dynamic>.from(featuredPlaylists!.map((x) => x.toJson())) : null,
        "user_state": userState?.toJson(),
        "global_config": globalConfig?.toJson(),
        "charts": charts != null ? List<dynamic>.from(charts!.map((x) => x.toJson())) : null,
        "genres": genres != null ? List<dynamic>.from(genres!.map((x) => x.toJson())) : null,
      };
}
