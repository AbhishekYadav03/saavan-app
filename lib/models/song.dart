// To parse this JSON data, do
//
//     final song = songFromJson(jsonString);

import 'dart:convert';

Song songFromJson(String str) => Song.fromJson(json.decode(str));

String songToJson(Song data) => json.encode(data.toJson());

class Song {
  Song({
    this.id,
    this.type,
    this.song,
    this.album,
    this.year,
    this.music,
    this.musicId,
    this.primaryArtists,
    this.primaryArtistsId,
    this.featuredArtists,
    this.featuredArtistsId,
    this.singers,
    this.starring,
    this.image,
    this.label,
    this.albumid,
    this.language,
    this.origin,
    this.playCount,
    this.copyrightText,
    this.the320Kbps,
    this.isDolbyContent = false,
    this.explicitContent = 0,
    this.hasLyrics,
    this.lyricsSnippet,
    this.encryptedMediaUrl,
    this.encryptedMediaPath,
    this.mediaPreviewUrl,
    this.permaUrl,
    this.albumUrl,
    this.duration,
    this.rights,
    this.webp = true,
    this.starred,
    this.artistMap,
    this.releaseDate,
    this.vcode,
    this.vlink,
    this.trillerAvailable = false,
    this.labelUrl,
  });

  String? id;
  String? type;
  String? song;
  String? album;
  String? year;
  String? music;
  String? musicId;
  String? primaryArtists;
  String? primaryArtistsId;
  String? featuredArtists;
  String? featuredArtistsId;
  String? singers;
  String? starring;
  String? image;
  String? label;
  String? albumid;
  String? language;
  String? origin;
  String? playCount;
  String? copyrightText;
  String? the320Kbps;
  bool isDolbyContent;
  int explicitContent;
  String? hasLyrics;
  String? lyricsSnippet;
  String? encryptedMediaUrl;
  String? encryptedMediaPath;
  String? mediaPreviewUrl;
  String? permaUrl;
  String? albumUrl;
  String? duration;
  Rights? rights;
  bool webp;
  String? starred;
  Map<String, dynamic>? artistMap;
  DateTime? releaseDate;
  String? vcode;
  String? vlink;
  bool trillerAvailable;
  String? labelUrl;

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        id: json["id"],
        type: json["type"],
        song: json["song"],
        album: json["album"],
        year: json["year"],
        music: json["music"],
        musicId: json["music_id"],
        primaryArtists: json["primary_artists"],
        primaryArtistsId: json["primary_artists_id"],
        featuredArtists: json["featured_artists"],
        featuredArtistsId: json["featured_artists_id"],
        singers: json["singers"],
        starring: json["starring"],
        image: json["image"],
        label: json["label"],
        albumid: json["albumid"],
        language: json["language"],
        origin: json["origin"],
        playCount: json["play_count"],
        copyrightText: json["copyright_text"],
        the320Kbps: json["320kbps"],
        isDolbyContent: json["is_dolby_content"],
        explicitContent: json["explicit_content"],
        hasLyrics: json["has_lyrics"],
        lyricsSnippet: json["lyrics_snippet"],
        encryptedMediaUrl: json["encrypted_media_url"],
        encryptedMediaPath: json["encrypted_media_path"],
        mediaPreviewUrl: json["media_preview_url"],
        permaUrl: json["perma_url"],
        albumUrl: json["album_url"],
        duration: json["duration"],
        rights: Rights.fromJson(json["rights"]),
        webp: json["webp"],
        starred: json["starred"],
        artistMap: json["artistMap"],
        releaseDate: DateTime.parse(json["release_date"]),
        vcode: json["vcode"],
        vlink: json["vlink"],
        trillerAvailable: json["triller_available"],
        labelUrl: json["label_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "song": song,
        "album": album,
        "year": year,
        "music": music,
        "music_id": musicId,
        "primary_artists": primaryArtists,
        "primary_artists_id": primaryArtistsId,
        "featured_artists": featuredArtists,
        "featured_artists_id": featuredArtistsId,
        "singers": singers,
        "starring": starring,
        "image": image,
        "label": label,
        "albumid": albumid,
        "language": language,
        "origin": origin,
        "play_count": playCount,
        "copyright_text": copyrightText,
        "320kbps": the320Kbps,
        "is_dolby_content": isDolbyContent,
        "explicit_content": explicitContent,
        "has_lyrics": hasLyrics,
        "lyrics_snippet": lyricsSnippet,
        "encrypted_media_url": encryptedMediaUrl,
        "encrypted_media_path": encryptedMediaPath,
        "media_preview_url": mediaPreviewUrl,
        "perma_url": permaUrl,
        "album_url": albumUrl,
        "duration": duration,
        "rights": rights?.toJson(),
        "webp": webp,
        "starred": starred,
        "artistMap": artistMap,
        "release_date":
            "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}",
        "vcode": vcode,
        "vlink": vlink,
        "triller_available": trillerAvailable,
        "label_url": labelUrl,
      };
}

class Rights {
  Rights({
    this.code,
    required this.reason,
    this.cacheable = true,
    this.deleteCachedObject = false,
  });

  int? code;
  String reason;
  bool cacheable;
  bool deleteCachedObject;

  factory Rights.fromJson(Map<String, dynamic> json) => Rights(
        code: json["code"],
        reason: json["reason"],
        cacheable: json["cacheable"],
        deleteCachedObject: json["delete_cached_object"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "reason": reason,
        "cacheable": cacheable,
        "delete_cached_object": deleteCachedObject,
      };
}
