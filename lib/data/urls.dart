class Urls {
  static const String homeData = "__call=content.getHomepageData$jsonFormat$appVersion";
  static const String trending = "__call=content.getTrending$albumEntity$languageHindi$ctx$appVersion$jsonFormat";
  static const String albumInfo = "__call=content.getAlbumDetails&albumid=";
  static const String songUrlInfo = "__call=song.generateAuthToken&url=";
  static const String searchInfo = "__call=autocomplete.get$jsonFormat&query=";

  ///
  static const String appVersion = "&api_version=4";
  static const String jsonFormat = "&_format=json&_marker=0";
  static const String ctx = "&ctx=wap6dot0";
  static const String languageHindi = "&entity_language=hindi";
  static const String albumEntity = "&entity_type=album";
}
