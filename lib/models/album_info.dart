// To parse this JSON data, do
//
//     final albumInfo = albumInfoFromJson(jsonString);

/*

AlbumInfo albumInfoFromJson(String str) => AlbumInfo.fromJson(json.decode(str));

String albumInfoToJson(AlbumInfo data) => json.encode(data.toJson());

class AlbumInfo {
  AlbumInfo({
    this.title,
    this.name,
    this.year,
    this.releaseDate,
    this.primaryArtists,
    this.primaryArtistsId,
    this.albumid,
    this.permaUrl,
    this.image,
    required this.songs,
  });

  String? title;
  String? name;
  String? year;
  DateTime? releaseDate;
  String? primaryArtists;
  dynamic primaryArtistsId;
  String? albumid;
  String? permaUrl;
  String? image;
  List<Song> songs;

  factory AlbumInfo.fromJson(Map<String, dynamic> json) => AlbumInfo(
        title: json["title"],
        name: json["name"],
        year: json["year"],
        releaseDate: json["release_date"] != null && json["release_date"].toString() != ""
            ? DateTime.parse(json["release_date"])
            : null,
        primaryArtists: json["primary_artists"],
        primaryArtistsId: json["primary_artists_id"],
        albumid: json["albumid"],
        permaUrl: json["perma_url"],
        image: json["image"],
        songs: json["songs"] != null ? List<Song>.from(json["songs"].map((x) => Song.fromJson(x))) : [],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "name": name,
        "year": year,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "primary_artists": primaryArtists,
        "primary_artists_id": primaryArtistsId,
        "albumid": albumid,
        "perma_url": permaUrl,
        "image": image,
        "songs": List<dynamic>.from(songs.map((x) => x.toJson())),
      };
}
*/
