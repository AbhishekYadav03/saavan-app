import 'artist_map.dart';

class AlbumMoreInfo {
  AlbumMoreInfo({
    this.songCount,
    this.releaseDate,
    this.artistMap,
  });

  String? songCount;
  DateTime? releaseDate;
  ArtistMap? artistMap;

  factory AlbumMoreInfo.fromJson(Map<String, dynamic> json) => AlbumMoreInfo(
        songCount: json["song_count"],
        releaseDate: json["release_date"] != null &&
                json["release_date"].toString() != ""
            ? DateTime.parse(json["release_date"])
            : null,
        artistMap: json["artistMap"] != null
            ? ArtistMap.fromJson(json["artistMap"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "song_count": songCount,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "artistMap": artistMap?.toJson(),
      };
}
