import 'dart:convert';

import 'package:saavan_app/models/artist.dart';
import 'package:saavan_app/models/show.dart';
import 'package:saavan_app/ui/imports.dart';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
  SearchResponse({
    this.albums,
    this.songs,
    this.playlists,
    this.artists,
    this.topQuery,
    this.shows,
    this.episodes,
  });

  AlbumsDatum? albums;
  SongsDatum? songs;
  PlaylistsDatum? playlists;
  ArtistsDatum? artists;
  SongsDatum? topQuery;
  ShowsDatum? shows;
  AlbumsDatum? episodes;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        albums: AlbumsDatum.fromJson(json["albums"]),
        songs: SongsDatum.fromJson(json["songs"]),
        playlists: PlaylistsDatum.fromJson(json["playlists"]),
        artists: ArtistsDatum.fromJson(json["artists"]),
        topQuery: SongsDatum.fromJson(json["topquery"]),
        shows: ShowsDatum.fromJson(json["shows"]),
        episodes: AlbumsDatum.fromJson(json["episodes"]),
      );

  Map<String, dynamic> toJson() => {
        "albums": albums?.toJson(),
        "songs": songs?.toJson(),
        "playlists": playlists?.toJson(),
        "artists": artists?.toJson(),
        "topquery": topQuery?.toJson(),
        "shows": shows?.toJson(),
        "episodes": episodes?.toJson(),
      };
}

class AlbumsDatum {
  AlbumsDatum({
    required this.data,
    required this.position,
  });

  List<Album> data;
  int? position;

  factory AlbumsDatum.fromJson(Map<String, dynamic> json) => AlbumsDatum(
        data: List<Album>.from(json["data"].map((x) => Album.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class ArtistsDatum {
  ArtistsDatum({
    required this.data,
    required this.position,
  });

  List<Artist> data;
  int? position;

  factory ArtistsDatum.fromJson(Map<String, dynamic> json) => ArtistsDatum(
        data: List<Artist>.from(json["data"].map((x) => Artist.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class PlaylistsDatum {
  PlaylistsDatum({
    required this.data,
    this.position,
  });

  List<PlaylistInfo> data;
  int? position;

  factory PlaylistsDatum.fromJson(Map<String, dynamic> json) => PlaylistsDatum(
        data: List<PlaylistInfo>.from(json["data"].map((x) => PlaylistInfo.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class ShowsDatum {
  ShowsDatum({
    required this.data,
    this.position,
  });

  List<Show> data;
  int? position;

  factory ShowsDatum.fromJson(Map<String, dynamic> json) => ShowsDatum(
        data: List<Show>.from(json["data"].map((x) => Show.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class SongsDatum {
  SongsDatum({
    required this.data,
    this.position,
  });

  List<Song> data;
  int? position;

  factory SongsDatum.fromJson(Map<String, dynamic> json) => SongsDatum(
        data: List<Song>.from(json["data"].map((x) => Song.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

String refactor(dynamic title) {
  return title.toString().replaceAll("&amp;", "&").replaceAll("&#039;", "'").replaceAll("&quot;", "\"");
}
