import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/models/song.dart';
import 'package:saavan_app/models/song_url.dart';

class AudioPlayerPageViewModel with ChangeNotifier {
  AudioPlayer get _player {
    return AudioPlayer();
  }

  AudioPlayer get player => _player;

  List<Song> songs = [];

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    _getSongUrl(currentSong.moreInfo?.encodedUrl ?? "");
    notifyListeners();
  }

  Song get currentSong => songs.elementAt(currentIndex);
  SongUrl? currentSongUrl;

  void setNextSong() {
    if (currentIndex >= 0 && songs.length - 1 != currentIndex) {
      currentIndex = currentIndex + 1;
    }
  }

  void setPreviousSong() {
    if (currentIndex > 0) {
      currentIndex = currentIndex - 1;
    }
  }

  void _getSongUrl(String encodedUrl) async {
    // __call=song.generateAuthToken&url=&bitrate=320&api_version=4&_format=json&ctx=web6dot0&_marker=0
    String bitrate = "&bitrate=320";
    String params = Urls.songUrlInfo + (encodedUrl) + bitrate + Urls.appVersion + Urls.jsonFormat;
    var response = await ApiService.getData(path: params);
    if (response is Success) {
      var data = songUrlFromJson(response.data.toString());
      currentSongUrl = data;
      if (currentSongUrl?.authUrl != null) {
        _play(currentSongUrl?.authUrl ?? '');
      }

      print("song.generateAuthToken : ${data.authUrl}");
    } else if (response is ApiError) {
      print(response.massage);
    }
  }

  void _play(String authUrl) async {
    // Catching errors at load time
    try {
      print("Error code: 200");
      await _player.setAudioSource(
          AudioSource.uri(Uri.parse("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
      print("Error code: 400");

      /*  await player.play();
      _listen();*/

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
    // Catching errors during playback (e.g. lost network connection)
    player.playbackEventStream.listen((event) {}, onError: (Object e, StackTrace st) {
      if (e is PlayerException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      } else {
        print('An error occurred: $e');
      }
    });
  }

  void _listen() {
    player.playerStateStream.listen((state) {
      switch (state.processingState) {
        case ProcessingState.idle:
          print("idle");
          break;
        case ProcessingState.loading:
          print("loading");
          break;
        case ProcessingState.buffering:
          print("buffering");
          break;
        case ProcessingState.ready:
          print("ready");
          break;
        case ProcessingState.completed:
          print("completed");
          break;
      }
    });
  }
}
