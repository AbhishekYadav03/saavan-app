import 'package:saavan_app/models/artist_map.dart';

class AlbumMoreInfo {
  AlbumMoreInfo({
    this.artistMap,
    this.songCount,
    this.copyrightText,
    this.music,
    this.ctr,
    this.year,
    this.songPid,
    this.isMovie,
    this.language,
    this.isDolbyContent = false,
  });

  ArtistMap? artistMap;
  String? songCount;
  String? copyrightText;
  String? music;
  String? ctr;
  String? year;
  String? songPid;
  String? isMovie;
  String? language;
  bool isDolbyContent;

  factory AlbumMoreInfo.fromJson(Map<String, dynamic> json) => AlbumMoreInfo(
        artistMap: json["artistMap"] != null ? ArtistMap.fromJson(json["artistMap"]) : null,
        songCount: json["song_count"],
        copyrightText: json["copyright_text"],
        music: json["music"],
        ctr: json["ctr"]?.toString(),
        year: json["year"],
        songPid: json["song_pids"],
        isMovie: json["is_movie"],
        language: json["language"],
        isDolbyContent: json["is_dolby_content"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "artistMap": artistMap?.toJson(),
        "song_count": songCount,
        "copyright_text": copyrightText,
        "music": music,
        "ctr": ctr,
        "year": year,
        "song_pids": songPid,
        "is_movie": isMovie,
        "language": language,
        "is_dolby_content": isDolbyContent,
      };
}
