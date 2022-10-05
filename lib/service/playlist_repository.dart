import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/models/song.dart';
import 'package:saavan_app/models/song_url.dart';

class DemoPlaylist {
  List<Song> songs = [];

  Future<String?> getSongUrl(String encodedUrl) async {
    SongUrl currentSongUrl;

    // __call=song.generateAuthToken&url=&bitrate=320&api_version=4&_format=json&ctx=web6dot0&_marker=0
    String bitrate = "&bitrate=160";
    String params = Urls.songUrlInfo + (encodedUrl) + bitrate + Urls.apiVersion + Urls.jsonFormat;
    var response = await ApiService.getData(path: params);
    if (response is Success) {
      var data = songUrlFromJson(response.data.toString());
      currentSongUrl = data;
      if (currentSongUrl.authUrl != null) {
        String songUrl = await ApiService.getUrlLocation(currentSongUrl.authUrl ?? '') ?? '';
        return songUrl;
      }
    } else if (response is ApiError) {
      print(response.massage);
    }
    return null;
  }
}
