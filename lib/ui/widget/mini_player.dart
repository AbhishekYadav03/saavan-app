

import 'dart:ui';

import 'package:just_audio/just_audio.dart';

import '../imports.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<AudioPlayerPageViewModel>(builder: (context, view, _) {
        if (view.songs.isNotEmpty) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AudioPlayerPage.route);
            },
            child: Container(
              color: Colors.green,
              height: 66,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(imageUrl: view.currentSong?.image ?? ""),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                view.currentSong?.title ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                view.currentSong?.artistsName ?? "",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        StreamBuilder<PlayerState>(
                            stream: view.player.playerStateStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                ProcessingState? processingState = snapshot.data?.processingState;
                                if (processingState == ProcessingState.completed) {
                                  print(snapshot.data?.processingState);
                                  view.setNextSongOnly();
                                }
                                return Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                      color: Colors.white, borderRadius: BorderRadius.circular(24)),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        height: 48,
                                        width: 48,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(24),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                                            child: Container(
                                              color: Colors.black.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: IconButton(
                                            onPressed: () {
                                              if (view.player.playing) {
                                                view.player.pause();
                                              } else {
                                                view.player.play();
                                              }
                                            },
                                            splashRadius: 24,
                                            icon: Icon(
                                              !view.player.playing
                                                  ? Icons.play_arrow_rounded
                                                  : Icons.pause_rounded,
                                              color: Colors.white,
                                              size: 34,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return const SizedBox();
                            }),
                        Material(
                          color: Colors.transparent,
                          child: IconButton(
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                            splashRadius: 24,
                            onPressed: view.setNextSong,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<Duration>(
                    stream: view.player.positionStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Duration position = snapshot.data ?? Duration.zero;
                        Duration duration = view.player.duration ?? Duration.zero;

                        return SizedBox(
                          height: 1,
                          child: Stack(
                            children: [
                              IgnorePointer(
                                child: SliderTheme(
                                  data: Theme.of(context).sliderTheme.copyWith(
                                    thumbShape: SliderComponentShape.noThumb,
                                    trackHeight: 1.0,
                                    trackShape: const RoundedRectSliderTrackShape(),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    activeColor: Colors.grey,
                                    inactiveColor: Colors.black,
                                    max: duration.inSeconds.toDouble(),
                                    value: view.player.bufferedPosition.inSeconds.toDouble(),
                                    onChanged: (val) {},
                                  ),
                                ),
                              ),
                              SliderTheme(
                                data: Theme.of(context).sliderTheme.copyWith(
                                  trackHeight: 1.0,
                                  thumbShape: SliderComponentShape.noThumb,
                                  trackShape: const RoundedRectSliderTrackShape(),
                                ),
                                child: Slider(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.transparent,
                                  min: 0,
                                  max: duration.inSeconds.toDouble(),
                                  value: position.inSeconds.toDouble(),
                                  onChanged: (val) {
                                    Duration position = Duration(seconds: val.floor());
                                    view.seekTo(position);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
