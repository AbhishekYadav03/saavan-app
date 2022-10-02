class PlaylistMoreInfo {
  PlaylistMoreInfo({
    this.songCount,
    this.firstname,
    this.followerCount,
    this.lastUpdated,
    this.uid,
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

  String? songCount;
  String? firstname;
  String? followerCount;
  String? lastUpdated;
  String? uid;
  dynamic artistName;
  String? entityType;
  String? entitySubType;
  bool? videoAvailable;
  bool? isDolbyContent;
  dynamic subTypes;
  dynamic images;
  String? lastname;
  String? language;

  factory PlaylistMoreInfo.fromJson(Map<String, dynamic> json) => PlaylistMoreInfo(
        songCount: json["song_count"],
        firstname: json["firstname"],
        followerCount: json["follower_count"],
        lastUpdated: json["last_updated"],
        uid: json["uid"],
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
        "song_count": songCount,
        "firstname": firstname,
        "follower_count": followerCount,
        "last_updated": lastUpdated,
        "uid": uid,
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
