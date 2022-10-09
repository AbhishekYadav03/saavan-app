import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:saavan_app/models/song.dart';
import 'package:saavan_app/notifier/play_button_notifier.dart';
import 'package:saavan_app/notifier/progress_notifier.dart';
import 'package:saavan_app/notifier/repeat_button_notifier.dart';
import 'package:saavan_app/service/playlist_repository.dart';
import 'package:saavan_app/service/service_locator.dart';

class AudioServiceManager {
  // Listeners: Updates going to the UI

  final ProgressNotifier progressNotifier = ProgressNotifier();
  final RepeatButtonNotifier repeatButtonNotifier = RepeatButtonNotifier();
  final PlayButtonNotifier playButtonNotifier = PlayButtonNotifier();
  final currentSongNotifier = ValueNotifier<MediaItem?>(null);
  final playlistNotifier = ValueNotifier<List<MediaItem>>([]);

  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final isLastSongNotifier = ValueNotifier<bool>(true);
  final isShuffleModeEnabledNotifier = ValueNotifier<bool>(false);

  final _audioHandler = getIt<AudioHandler>();
  bool initialized = false;

  // Events: Calls coming from the UI
  void init() async {
    initialized = true;

    _listenToChangesInPlaylist();
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToBufferedPosition();
    _listenToTotalDuration();
    _listenToChangesInSong();
    await Future.delayed(const Duration(seconds: 1)).then((value) => play());
  }

  Future startPlayback(List<Song> songs) async {
    if (initialized) {
      print(initialized);
      await _updatePlaylist(songs);
      play();
    } else {
      print(initialized);
      await _loadPlaylist(songs);
      init();
    }
  }

  Future<void> _loadPlaylist(List<Song> songs) async {
    List<MediaItem> mediaItems = [];
    for (var song in songs) {
      MediaItem mediaItem = await _generateMediaItem(song);
      mediaItems.add(mediaItem);
    }
    _audioHandler.addQueueItems(mediaItems);
  }

  Future<void> _updatePlaylist(List<Song> songs) async {
    List<MediaItem> mediaItems = [];
    for (var song in songs) {
      MediaItem mediaItem = await _generateMediaItem(song);
      mediaItems.add(mediaItem);
    }
    var previousIndex = _audioHandler.queue.value.length - 1;
    _audioHandler.addQueueItems(mediaItems);
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      _audioHandler.skipToNext();
      var afterIndex = _audioHandler.queue.value.length;
      print("update indexs $previousIndex $afterIndex");
      if (afterIndex > previousIndex) {
        removePrevious(0, previousIndex);
      }
    });
  }

  Future<void> _add(Song song) async {
    var mediaItem = await _generateMediaItem(song);
    _audioHandler.addQueueItem(mediaItem);
  }

  Future<MediaItem> _generateMediaItem(Song song) async {
    final songRepository = getIt<DemoPlaylist>();
    final String? songUrl = await songRepository.getSongUrl(song.moreInfo?.encodedUrl ?? "");
    final MediaItem mediaItem = MediaItem(
      id: song.id ?? '',
      album: song.moreInfo?.album ?? '',
      title: song.title ?? '',
      artist: song.artistsName,
      displayDescription: song.description,
      displayTitle: song.title,
      displaySubtitle: song.description,
      artUri: Uri.tryParse(song.image ?? ""),
      extras: {'url': songUrl},
    );
    return mediaItem;
  }

  void removePrevious(int start, int end) async {
    for (int index = start; index <= end; index++) {
      await _audioHandler.removeQueueItemAt(0);
    }
  }

  // void remove() {
  //   final lastIndex = _audioHandler.queue.value.length - 1;
  //   if (lastIndex < 0) return;
  //   _audioHandler.removeQueueItemAt(lastIndex);
  // }

  void _listenToChangesInPlaylist() {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) {
        playlistNotifier.value = [];
        currentSongNotifier.value = null;
      } else {
        playlistNotifier.value = playlist;
      }
      _updateSkipButtons();
    });
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading || processingState == AudioProcessingState.buffering) {
        playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToBufferedPosition() {
    _audioHandler.playbackState.listen((playbackState) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: playbackState.bufferedPosition,
        total: oldState.total,
      );
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: mediaItem?.duration ?? Duration.zero,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      currentSongNotifier.value = mediaItem;
      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;
    if (playlist.length < 2 || mediaItem == null) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void play() => _audioHandler.play();
  void pause() => _audioHandler.pause();

  void seek(Duration position) => _audioHandler.seek(position);

  void previous() => _audioHandler.skipToPrevious();
  void skipToIndex(index) => _audioHandler.skipToQueueItem(index);
  void next() => _audioHandler.skipToNext();

  void repeat() {
    repeatButtonNotifier.nextState();
    final repeatMode = repeatButtonNotifier.value;
    switch (repeatMode) {
      case RepeatState.off:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
        break;
      case RepeatState.repeatSong:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
        break;
      case RepeatState.repeatPlaylist:
        _audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
        break;
    }
  }

  void shuffle() {
    final enable = !isShuffleModeEnabledNotifier.value;
    isShuffleModeEnabledNotifier.value = enable;
    if (enable) {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.all);
    } else {
      _audioHandler.setShuffleMode(AudioServiceShuffleMode.none);
    }
  }

  void dispose() {
    _audioHandler.customAction('dispose');
  }

  void stop() {
    _audioHandler.stop();
  }
}
