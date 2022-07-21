class PlaylistMoreInfo {
  PlaylistMoreInfo({
    this.songCount,
    this.firstname,
    this.followerCount,
    this.lastUpdated,
    this.uid,
  });

  String? songCount;
  String? firstname;
  String? followerCount;
  String? lastUpdated;
  String? uid;

  factory PlaylistMoreInfo.fromJson(Map<String, dynamic> json) =>
      PlaylistMoreInfo(
        songCount: json["song_count"],
        firstname: json["firstname"],
        followerCount: json["follower_count"],
        lastUpdated: json["last_updated"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "song_count": songCount,
        "firstname": firstname,
        "follower_count": followerCount,
        "last_updated": lastUpdated,
        "uid": uid,
      };
}
