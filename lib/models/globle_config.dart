import 'package:git_app/models/stream_config.dart';

class GlobalConfig {
  GlobalConfig({
    this.spotlightImageWidth,
    this.spotlightImageHeight,
    this.spotlightImageExpiry,
    this.spotlightViewImageWidth,
    this.spotlightViewImageHeight,
    this.spotlightViewImageExpiry,
    this.spotlightImage,
    this.spotlightViewImage,
    this.spotlightMovieAcronym,
    this.spotlightAction,
    this.spotlightContent,
    this.spotlightContentName,
    this.spotlightViewAction,
    this.spotlightViewContent,
    this.connectionTimeout,
    this.socketTimeout,
    this.songObjectVersion,
    this.streamConfig,
    this.notificationDuration,
    this.supportedLanguages,
    this.radioSupportedLanguages,
    this.afEnabled,
    this.cfEnabled,
    this.weeklyTopSongsListid,
    this.randomSongsListid,
  });

  String? spotlightImageWidth;
  String? spotlightImageHeight;
  String? spotlightImageExpiry;
  String? spotlightViewImageWidth;
  String? spotlightViewImageHeight;
  String? spotlightViewImageExpiry;
  String? spotlightImage;
  String? spotlightViewImage;
  String? spotlightMovieAcronym;
  String? spotlightAction;
  String? spotlightContent;
  String? spotlightContentName;
  String? spotlightViewAction;
  String? spotlightViewContent;
  int? connectionTimeout;
  int? socketTimeout;
  String? songObjectVersion;
  StreamConfig? streamConfig;
  int? notificationDuration;
  List<String>? supportedLanguages;
  List<String>? radioSupportedLanguages;
  String? afEnabled;
  String? cfEnabled;
  int? weeklyTopSongsListid;
  int? randomSongsListid;

  factory GlobalConfig.fromJson(Map<String, dynamic> json) => GlobalConfig(
        spotlightImageWidth: json["spotlight_image_width"],
        spotlightImageHeight: json["spotlight_image_height"],
        spotlightImageExpiry: json["spotlight_image_expiry"],
        spotlightViewImageWidth: json["spotlight_view_image_width"],
        spotlightViewImageHeight: json["spotlight_view_image_height"],
        spotlightViewImageExpiry: json["spotlight_view_image_expiry"],
        spotlightImage: json["spotlight_image"],
        spotlightViewImage: json["spotlight_view_image"],
        spotlightMovieAcronym: json["spotlight_movie_acronym"],
        spotlightAction: json["spotlight_action"],
        spotlightContent: json["spotlight_content"],
        spotlightContentName: json["spotlight_content_name"],
        spotlightViewAction: json["spotlight_view_action"],
        spotlightViewContent: json["spotlight_view_content"],
        connectionTimeout: json["connection_timeout"],
        socketTimeout: json["socket_timeout"],
        songObjectVersion: json["song_object_version"],
        streamConfig: StreamConfig.fromJson(json["stream_config"]),
        notificationDuration: json["notification_duration"],
        supportedLanguages:
            List<String>.from(json["supported_languages"].map((x) => x)),
        radioSupportedLanguages:
            List<String>.from(json["radio_supported_languages"].map((x) => x)),
        afEnabled: json["af_enabled"],
        cfEnabled: json["cf_enabled"],
        weeklyTopSongsListid: json["weekly_top_songs_listid"],
        randomSongsListid: json["random_songs_listid"],
      );

  Map<String, dynamic> toJson() => {
        "spotlight_image_width": spotlightImageWidth,
        "spotlight_image_height": spotlightImageHeight,
        "spotlight_image_expiry": spotlightImageExpiry,
        "spotlight_view_image_width": spotlightViewImageWidth,
        "spotlight_view_image_height": spotlightViewImageHeight,
        "spotlight_view_image_expiry": spotlightViewImageExpiry,
        "spotlight_image": spotlightImage,
        "spotlight_view_image": spotlightViewImage,
        "spotlight_movie_acronym": spotlightMovieAcronym,
        "spotlight_action": spotlightAction,
        "spotlight_content": spotlightContent,
        "spotlight_content_name": spotlightContentName,
        "spotlight_view_action": spotlightViewAction,
        "spotlight_view_content": spotlightViewContent,
        "connection_timeout": connectionTimeout,
        "socket_timeout": socketTimeout,
        "song_object_version": songObjectVersion,
        "stream_config": streamConfig?.toJson(),
        "notification_duration": notificationDuration,
        "supported_languages": supportedLanguages != null
            ? List<dynamic>.from(supportedLanguages!.map((x) => x))
            : null,
        "radio_supported_languages": radioSupportedLanguages != null
            ? List<dynamic>.from(radioSupportedLanguages!.map((x) => x))
            : null,
        "af_enabled": afEnabled,
        "cf_enabled": cfEnabled,
        "weekly_top_songs_listid": weeklyTopSongsListid,
        "random_songs_listid": randomSongsListid,
      };
}
