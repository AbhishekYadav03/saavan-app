import 'artist_map.dart';

class Song {
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
  MoreInfo? moreInfo;

  Song(
      {this.id,
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
      this.moreInfo});

  String? get artistsName {
    String? names = "";
    moreInfo?.artistMap?.primaryArtists?.asMap().forEach((index, artist) {
      if (index == (moreInfo?.artistMap?.primaryArtists?.length ?? 0) - 1) {
        names = "$names ${artist.name}";
      } else {
        names = "$names ${artist.name},";
      }
    });
    return names;
  }

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    headerDesc = json['header_desc'];
    type = json['type'];
    permaUrl = json['perma_url'];
    image = json['image'];
    language = json['language'];
    year = json['year'];
    playCount = json['play_count'];
    explicitContent = json['explicit_content'];
    listCount = json['list_count'];
    listType = json['list_type'];
    list = json['list'];
    moreInfo = json['more_info'] != null ? MoreInfo.fromJson(json['more_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['header_desc'] = headerDesc;
    data['type'] = type;
    data['perma_url'] = permaUrl;
    data['image'] = image;
    data['language'] = language;
    data['year'] = year;
    data['play_count'] = playCount;
    data['explicit_content'] = explicitContent;
    data['list_count'] = listCount;
    data['list_type'] = listType;
    data['list'] = list;
    if (moreInfo != null) {
      data['more_info'] = moreInfo!.toJson();
    }
    return data;
  }
}

class MoreInfo {
  String? music;
  String? albumId;
  String? album;
  String? label;
  String? origin;
  bool? isDolbyContent;
  String? s320kbps;
  String? encryptedMediaUrl;
  String? encryptedCacheUrl;
  String? albumUrl;
  String? duration;
  Rights? rights;
  String? cacheState;
  String? hasLyrics;
  String? lyricsSnippet;
  String? starred;
  String? copyrightText;
  ArtistMap? artistMap;
  String? releaseDate;
  String? vcode;
  String? vlink;
  bool? trillerAvailable;
  String? webp;
  String? lyricsId;

  MoreInfo(
      {this.music,
      this.albumId,
      this.album,
      this.label,
      this.origin,
      this.isDolbyContent,
      this.s320kbps,
      this.encryptedMediaUrl,
      this.encryptedCacheUrl,
      this.albumUrl,
      this.duration,
      this.rights,
      this.cacheState,
      this.hasLyrics,
      this.lyricsSnippet,
      this.starred,
      this.copyrightText,
      this.artistMap,
      this.releaseDate,
      this.vcode,
      this.vlink,
      this.trillerAvailable,
      this.webp,
      this.lyricsId});

  MoreInfo.fromJson(Map<String, dynamic> json) {
    music = json['music'];
    albumId = json['album_id'];
    album = json['album'];
    label = json['label'];
    origin = json['origin'];
    isDolbyContent = json['is_dolby_content'];
    s320kbps = json['320kbps'];
    encryptedMediaUrl = json['encrypted_media_url'];
    encryptedCacheUrl = json['encrypted_cache_url'];
    albumUrl = json['album_url'];
    duration = json['duration'];
    rights = json['rights'] != null ? Rights.fromJson(json['rights']) : null;
    cacheState = json['cache_state'];
    hasLyrics = json['has_lyrics'];
    lyricsSnippet = json['lyrics_snippet'];
    starred = json['starred'];
    copyrightText = json['copyright_text'];
    artistMap = json['artistMap'] != null ? ArtistMap.fromJson(json['artistMap']) : null;
    releaseDate = json['release_date'];
    vcode = json['vcode'];
    vlink = json['vlink'];
    trillerAvailable = json['triller_available'];
    webp = json['webp'];
    lyricsId = json['lyrics_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['music'] = music;
    data['album_id'] = albumId;
    data['album'] = album;
    data['label'] = label;
    data['origin'] = origin;
    data['is_dolby_content'] = isDolbyContent;
    data['320kbps'] = s320kbps;
    data['encrypted_media_url'] = encryptedMediaUrl;
    data['encrypted_cache_url'] = encryptedCacheUrl;
    data['album_url'] = albumUrl;
    data['duration'] = duration;
    if (rights != null) {
      data['rights'] = rights!.toJson();
    }
    data['cache_state'] = cacheState;
    data['has_lyrics'] = hasLyrics;
    data['lyrics_snippet'] = lyricsSnippet;
    data['starred'] = starred;
    data['copyright_text'] = copyrightText;
    if (artistMap != null) {
      data['artistMap'] = artistMap!.toJson();
    }
    data['release_date'] = releaseDate;
    data['vcode'] = vcode;
    data['vlink'] = vlink;
    data['triller_available'] = trillerAvailable;
    data['webp'] = webp;
    data['lyrics_id'] = lyricsId;
    return data;
  }

  String get encodedUrl {
    return Uri.encodeComponent(encryptedMediaUrl ?? "");
  }
}

class Rights {
  String? code;
  String? cacheable;
  String? deleteCachedObject;
  String? reason;

  Rights({this.code, this.cacheable, this.deleteCachedObject, this.reason});

  Rights.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    cacheable = json['cacheable'];
    deleteCachedObject = json['delete_cached_object'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['cacheable'] = cacheable;
    data['delete_cached_object'] = deleteCachedObject;
    data['reason'] = reason;
    return data;
  }
}
