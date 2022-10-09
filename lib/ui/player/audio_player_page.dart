import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:saavan_app/audio_player/audio_manager.dart';
import 'package:saavan_app/service/service_locator.dart';
import 'package:saavan_app/ui/imports.dart';
import 'package:saavan_app/ui/player/play_list_bottom_sheet.dart';
import 'package:saavan_app/ui/widget/play_button.dart';

import '../../notifier/progress_notifier.dart';

class AudioPlayerPage extends StatelessWidget {
  static const String route = "AudioPlayerPage";

  const AudioPlayerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<MediaItem?>(
          valueListenable: getIt<AudioServiceManager>().currentSongNotifier,
          builder: (context, currentSong, _) {
            return SafeArea(
              child: Stack(
                children: [
                  CachedNetworkImage(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                    imageUrl: currentSong?.artUri?.toString() ?? "",
                    progressIndicatorBuilder: (context, url, downloadProgress) {
                      return Center(
                        child: CircularProgressIndicator(value: downloadProgress.progress),
                      );
                    },
                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 30.0,
                      sigmaY: 30.0,
                    ),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                splashRadius: 24,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Now Playing",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: Icon(
                              Icons.alarm_outlined,
                              size: 26,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    currentSong?.title ?? "",
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    (currentSong?.artist ?? "") + '\n',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.white54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            width: 300,
                            fit: BoxFit.cover,
                            height: 300,
                            imageUrl: currentSong?.artUri?.toString().replaceAll("150x150", "500x500") ?? "",
                            progressIndicatorBuilder: (context, url, downloadProgress) {
                              return Center(
                                child: CircularProgressIndicator(value: downloadProgress.progress),
                              );
                            },
                            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      ValueListenableBuilder<ProgressBarState>(
                        valueListenable: getIt<AudioServiceManager>().progressNotifier,
                        builder: (context, progress, _) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  IgnorePointer(
                                    child: SliderTheme(
                                      data: Theme.of(context).sliderTheme.copyWith(
                                            thumbShape: SliderComponentShape.noThumb,
                                            trackHeight: 1.0,
                                            trackShape: const RoundedRectSliderTrackShape(),
                                            inactiveTrackColor: Colors.transparent,
                                          ),
                                      child: Slider(
                                        min: 0,
                                        max: progress.total.inSeconds.toDouble(),
                                        value: progress.buffered.inSeconds.toDouble(),
                                        onChanged: (val) {},
                                      ),
                                    ),
                                  ),
                                  SliderTheme(
                                    data: Theme.of(context).sliderTheme.copyWith(
                                          trackHeight: 1.0,
                                          trackShape: const RoundedRectSliderTrackShape(),
                                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                                        ),
                                    child: Slider(
                                      thumbColor: Colors.white,
                                      activeColor: Colors.white,
                                      inactiveColor: Colors.white24,
                                      min: 0,
                                      max: progress.total.inSeconds.toDouble(),
                                      value: progress.current.inSeconds.toDouble(),
                                      onChanged: (val) {
                                        Duration position = Duration(seconds: val.floor());
                                        getIt<AudioServiceManager>().seek(position);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      progress.current.inSeconds.toString().parsePlayerDuration,
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                    Text(
                                      progress.total.inSeconds.toString().parsePlayerDuration,
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 80),
                      Row(
                        children: [
                          ValueListenableBuilder<bool>(
                              valueListenable: getIt<AudioServiceManager>().isShuffleModeEnabledNotifier,
                              builder: (context, enabled, _) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      onPressed: () {
                                        getIt<AudioServiceManager>().shuffle();
                                      },
                                      splashRadius: 24,
                                      icon: Icon(
                                        Icons.shuffle_rounded,
                                        color: enabled ? Colors.green : Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          const Spacer(),
                          ValueListenableBuilder<bool>(
                            valueListenable: getIt<AudioServiceManager>().isFirstSongNotifier,
                            builder: (context, isFirst, _) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      if (!isFirst) getIt<AudioServiceManager>().previous();
                                    },
                                    splashRadius: 24,
                                    icon: const Icon(
                                      Icons.skip_previous_rounded,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          const PlayButton(),
                          const Spacer(),
                          ValueListenableBuilder<bool>(
                            valueListenable: getIt<AudioServiceManager>().isLastSongNotifier,
                            builder: (context, isLast, _) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    onPressed: () {
                                      if (!isLast) getIt<AudioServiceManager>().next();
                                    },
                                    splashRadius: 24,
                                    icon: const Icon(
                                      Icons.skip_next_rounded,
                                      color: Colors.white,
                                      size: 34,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Material(
                              color: Colors.transparent,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.playlist_play_rounded,
                                  color: Colors.white,
                                  size: 34,
                                ),
                                splashRadius: 24,
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    builder: (BuildContext context) {
                                      return const PlaylistBottomSheet();
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
