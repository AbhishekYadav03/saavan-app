// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) =>
    SearchResponse.fromJson(json.decode(str));

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

  Albums? albums;
  Songs? songs;
  Playlists? playlists;
  Artists? artists;
  Songs? topQuery;
  Shows? shows;
  Albums? episodes;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        albums: Albums.fromJson(json["albums"]),
        songs: Songs.fromJson(json["songs"]),
        playlists: Playlists.fromJson(json["playlists"]),
        artists: Artists.fromJson(json["artists"]),
        topQuery: Songs.fromJson(json["topquery"]),
        shows: Shows.fromJson(json["shows"]),
        episodes: Albums.fromJson(json["episodes"]),
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

class Albums {
  Albums({
    required this.data,
    required this.position,
  });

  List<AlbumsDatum> data;
  int? position;

  factory Albums.fromJson(Map<String, dynamic> json) => Albums(
        data: List<AlbumsDatum>.from(
            json["data"].map((x) => AlbumsDatum.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class AlbumsDatum {
  AlbumsDatum({
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
  PurpleMoreInfo? moreInfo;
  String? explicitContent;
  bool? miniObj;
  String? description;

  factory AlbumsDatum.fromJson(Map<String, dynamic> json) => AlbumsDatum(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: PurpleMoreInfo.fromJson(json["more_info"]),
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

class PurpleMoreInfo {
  PurpleMoreInfo({
    this.music,
    this.ctr,
    this.year,
    this.isMovie,
    this.language,
    this.songPids,
  });

  String? music;
  int? ctr;
  String? year;
  String? isMovie;
  String? language;
  String? songPids;

  factory PurpleMoreInfo.fromJson(Map<String, dynamic> json) => PurpleMoreInfo(
        music: json["music"],
        ctr: json["ctr"],
        year: json["year"],
        isMovie: json["is_movie"],
        language: json["language"],
        songPids: json["song_pids"],
      );

  Map<String, dynamic> toJson() => {
        "music": music,
        "ctr": ctr,
        "year": year,
        "is_movie": isMovie,
        "language": language,
        "song_pids": songPids,
      };
}

class Artists {
  Artists({
    required this.data,
    required this.position,
  });

  List<ArtistsDatum> data;
  int? position;

  factory Artists.fromJson(Map<String, dynamic> json) => Artists(
        data: List<ArtistsDatum>.from(
            json["data"].map((x) => ArtistsDatum.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class ArtistsDatum {
  ArtistsDatum({
    this.id,
    this.title,
    this.image,
    this.extra,
    this.type,
    this.miniObj,
    this.isRadioPresent,
    this.ctr,
    this.entity,
    this.description,
    this.position,
  });

  String? id;
  String? title;
  String? image;
  String? extra;
  String? type;
  bool? miniObj;
  bool? isRadioPresent;
  int? ctr;
  int? entity;
  String? description;
  int? position;

  factory ArtistsDatum.fromJson(Map<String, dynamic> json) => ArtistsDatum(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        extra: json["extra"],
        type: json["type"],
        miniObj: json["mini_obj"],
        isRadioPresent: json["isRadioPresent"],
        ctr: json["ctr"],
        entity: json["entity"],
        description: json["description"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "extra": extra,
        "type": type,
        "mini_obj": miniObj,
        "isRadioPresent": isRadioPresent,
        "ctr": ctr,
        "entity": entity,
        "description": description,
        "position": position,
      };
}

class Playlists {
  Playlists({
    required this.data,
    this.position,
  });

  List<PlaylistsDatum> data;
  int? position;

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
        data: List<PlaylistsDatum>.from(
            json["data"].map((x) => PlaylistsDatum.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class PlaylistsDatum {
  PlaylistsDatum({
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
  FluffyMoreInfo? moreInfo;
  String? explicitContent;
  bool? miniObj;
  String? description;

  factory PlaylistsDatum.fromJson(Map<String, dynamic> json) => PlaylistsDatum(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: FluffyMoreInfo.fromJson(json["more_info"]),
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

class FluffyMoreInfo {
  FluffyMoreInfo({
    this.firstname,
    this.artistName,
    this.entityType,
    this.entitySubType,
    this.videoAvailable,
    this.isDolbyContent,
    this.subTypes,
    this.images,
    this.lastname,
    this.language,
  });

  String? firstname;
  dynamic artistName;
  String? entityType;
  String? entitySubType;
  bool? videoAvailable;
  bool? isDolbyContent;
  dynamic subTypes;
  dynamic images;
  String? lastname;
  String? language;

  factory FluffyMoreInfo.fromJson(Map<String, dynamic> json) => FluffyMoreInfo(
        firstname: json["firstname"],
        artistName: json["artist_name"],
        entityType: json["entity_type"],
        entitySubType: json["entity_sub_type"],
        videoAvailable: json["video_available"],
        isDolbyContent: json["is_dolby_content"],
        subTypes: json["sub_types"],
        images: json["images"],
        lastname: json["lastname"],
        language: json["language"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "artist_name": artistName,
        "entity_type": entityType,
        "entity_sub_type": entitySubType,
        "video_available": videoAvailable,
        "is_dolby_content": isDolbyContent,
        "sub_types": subTypes,
        "images": images,
        "lastname": lastname,
        "language": language,
      };
}

class Shows {
  Shows({
    required this.data,
    this.position,
  });

  List<ShowsDatum> data;
  int? position;

  factory Shows.fromJson(Map<String, dynamic> json) => Shows(
        data: List<ShowsDatum>.from(
            json["data"].map((x) => ShowsDatum.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class ShowsDatum {
  ShowsDatum({
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
  TentacledMoreInfo? moreInfo;
  String? explicitContent;
  bool? miniObj;
  String? description;

  factory ShowsDatum.fromJson(Map<String, dynamic> json) => ShowsDatum(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: TentacledMoreInfo.fromJson(json["more_info"]),
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

class TentacledMoreInfo {
  TentacledMoreInfo({
    this.seasonNumber,
  });

  int? seasonNumber;

  factory TentacledMoreInfo.fromJson(Map<String, dynamic> json) =>
      TentacledMoreInfo(
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "season_number": seasonNumber,
      };
}

class Songs {
  Songs({
    required this.data,
    this.position,
  });

  List<SongsDatum> data;
  int? position;

  factory Songs.fromJson(Map<String, dynamic> json) => Songs(
        data: List<SongsDatum>.from(
            json["data"].map((x) => SongsDatum.fromJson(x))),
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "position": position,
      };
}

class SongsDatum {
  SongsDatum({
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
  StickyMoreInfo? moreInfo;
  String? explicitContent;
  bool? miniObj;
  String? description;

  factory SongsDatum.fromJson(Map<String, dynamic> json) => SongsDatum(
        id: json["id"],
        title: refactor(json["title"]),
        subtitle: json["subtitle"],
        type: json["type"],
        image: json["image"],
        permaUrl: json["perma_url"],
        moreInfo: StickyMoreInfo.fromJson(json["more_info"]),
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

class StickyMoreInfo {
  StickyMoreInfo({
    this.album,
    this.ctr,
    this.score,
    this.primaryArtists,
    this.singers,
    this.videoAvailable,
    this.trillerAvailable,
    this.language,
    this.vcode,
    this.vlink,
  });

  String? album;
  int? ctr;
  String? score;
  String? primaryArtists;
  String? singers;
  dynamic videoAvailable;
  bool? trillerAvailable;
  String? language;
  String? vcode;
  String? vlink;

  factory StickyMoreInfo.fromJson(Map<String, dynamic> json) => StickyMoreInfo(
        album: json["album"],
        ctr: json["ctr"],
        score: json["score"],
        primaryArtists: json["primary_artists"],
        singers: json["singers"],
        videoAvailable: json["video_available"],
        trillerAvailable: json["triller_available"],
        language: json["language"],
        vcode: json["vcode"],
        vlink: json["vlink"],
      );

  Map<String, dynamic> toJson() => {
        "album": album,
        "ctr": ctr,
        "score": score,
        "primary_artists": primaryArtists,
        "singers": singers,
        "video_available": videoAvailable,
        "triller_available": trillerAvailable,
        "language": language,
        "vcode": vcode,
        "vlink": vlink,
      };
}

String refactor(dynamic title) {
  return title
      .toString()
      .replaceAll("&amp;", "&")
      .replaceAll("&#039;", "'")
      .replaceAll("&quot;", "\"");
}
