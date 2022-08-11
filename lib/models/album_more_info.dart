import 'package:saavan_app/models/artist_map.dart';

class AlbumMoreInfo {
  AlbumMoreInfo({
    this.artistMap,
    this.songCount,
    this.copyrightText,
    this.isDolbyContent = false,
  });

  ArtistMap? artistMap;
  String? songCount;
  String? copyrightText;
  bool isDolbyContent;

  factory AlbumMoreInfo.fromJson(Map<String, dynamic> json) => AlbumMoreInfo(
        artistMap: json["artistMap"] != null ? ArtistMap.fromJson(json["artistMap"]) : null,
        songCount: json["song_count"],
        copyrightText: json["copyright_text"],
        isDolbyContent: json["is_dolby_content"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "artistMap": artistMap?.toJson(),
        "song_count": songCount,
        "copyright_text": copyrightText,
        "is_dolby_content": isDolbyContent,
      };
}
