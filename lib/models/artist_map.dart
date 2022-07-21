import 'package:saavan_app/models/artist.dart';

class ArtistMap {
  ArtistMap({
    this.primaryArtists,
    this.featuredArtists,
    this.artists,
  });

  List<Artist>? primaryArtists;
  List<Artist>? featuredArtists;
  List<Artist>? artists;

  factory ArtistMap.fromJson(Map<String, dynamic> json) => ArtistMap(
        primaryArtists: List<Artist>.from(
            json["primary_artists"].map((x) => Artist.fromJson(x))),
        featuredArtists: List<Artist>.from(
            json["featured_artists"].map((x) => Artist.fromJson(x))),
        artists:
            List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "primary_artists": primaryArtists != null
            ? List<dynamic>.from(primaryArtists!.map((x) => x))
            : null,
        "featured_artists": featuredArtists != null
            ? List<dynamic>.from(featuredArtists!.map((x) => x))
            : null,
        "artists": artists != null
            ? List<dynamic>.from(artists!.map((x) => x.toJson()))
            : null,
      };
}
