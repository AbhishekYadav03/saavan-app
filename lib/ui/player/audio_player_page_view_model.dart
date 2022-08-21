import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/models/song.dart';
import 'package:saavan_app/models/song_url.dart';

class AudioPlayerPageViewModel with ChangeNotifier {
  final AudioPlayer player = AudioPlayer();

  List<Song> songs = [];

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    _getSongUrl(currentSong.moreInfo?.encodedUrl ?? "");
    notifyListeners();
  }

  Song get currentSong => songs.elementAt(currentIndex);

  void setNextSong() {
    if (currentIndex >= 0 && songs.length - 1 != currentIndex) {
      currentIndex = currentIndex + 1;
      player.pause();
      print(currentIndex);
    }
  }

  void setNextSongOnly() {
    if (currentIndex >= 0 && songs.length - 1 != currentIndex) {
      print(currentIndex);
      _currentIndex = _currentIndex + 1;
      _getSongUrl(currentSong.moreInfo?.encodedUrl ?? "");
    }
  }

  void setPreviousSong() {
    if (currentIndex > 0) {
      currentIndex = currentIndex - 1;
      player.pause();
    }
  }

  void _getSongUrl(String encodedUrl) async {
    SongUrl currentSongUrl;

    // __call=song.generateAuthToken&url=&bitrate=320&api_version=4&_format=json&ctx=web6dot0&_marker=0
    String bitrate = "&bitrate=160";
    String params = Urls.songUrlInfo + (encodedUrl) + bitrate + Urls.appVersion + Urls.jsonFormat;
    var response = await ApiService.getData(path: params);
    if (response is Success) {
      var data = songUrlFromJson(response.data.toString());
      currentSongUrl = data;
      if (currentSongUrl.authUrl != null) {
        //_setSongSource("https://sdlhivkecdnems02.cdnsrv.jio.com/jiosaavn.cdn.jio.com/440/54d9e770352c3ada19df81d35273c992_96.mp4");
        // _setSongSource("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3");
        String songUrl = await ApiService.getUrlLocation(currentSongUrl.authUrl ?? '') ?? '';
        _setSongSource(songUrl);
        print("song.generateAuthToken : $songUrl");
      }
    } else if (response is ApiError) {
      print(response.massage);
    }
  }

  void _setSongSource(String authUrl) async {
    await player.setAudioSource(AudioSource.uri(Uri.parse(authUrl)));
    play();
   notifyListeners();
  }

  void play() async {
    try {
      player.play();
      // Catching errors during playback (e.g. lost network connection)
      player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace st) {
        if (e is PlayerException) {
          print('Error code: ${e.code}');
          print('Error message: ${e.message}');
        } else {
          print('An error occurred: $e');
        }
      });

      // _listen();
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // Linux/Windows: maps to PlayerErrorCode.index
      print("Error code: ${e.code}");
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web/Linux: a generic message
      // Windows: MediaPlayerError.message
      print("Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      print("Connection aborted: ${e.message}");
    } catch (e) {
      // Fallback for all other errors
      print('An error occured: $e');
    }
  }

  void seekTo(Duration pos) async {
    await player.seek(pos);
  }
}
