import 'dart:ui';

import 'package:saavan_app/ui/home/home.dart';
import 'package:saavan_app/ui/imports.dart';

class AudioPlayerPage extends StatelessWidget {
  static const String route = "AudioPlayerPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AudioPlayerPageViewModel>(builder: (context, view, _) {
        return SafeArea(
          child: Stack(
            children: [
              CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                imageUrl: view.currentSong.image ?? "",
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
                      const Padding(
                        padding: EdgeInsets.all(24),
                        child: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          size: 32,
                          color: Colors.white,
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
                                view.currentSong.title ?? "",
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
                                (view.currentSong.artistsName ?? "") + '\n',
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
                        imageUrl: view.currentSong.image?.replaceAll("150x150", "500x500") ?? "",
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
                  StreamBuilder<Duration>(
                    stream: view.player.positionStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Duration position = snapshot.data ?? Duration.zero;
                        Duration duration = view.player.duration ?? Duration.zero;

                        return Column(
                          children: [
                            Slider(
                              thumbColor: Colors.white,
                              activeColor: Colors.white,
                              inactiveColor: Colors.white24,
                              min: 0,
                              max: duration.inSeconds.toDouble(),
                              value: position.inSeconds.toDouble(),
                              onChanged: (val) {
                                Duration position = Duration(seconds: val.floor());
                                view.seekTo(position);
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    position.inSeconds.toString().parsePlayerDuration,
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                  ),
                                  Text(
                                    duration.inSeconds.toString().parsePlayerDuration,
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
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 80),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: () {},
                            splashRadius: 24,
                            icon: const Icon(
                              Icons.shuffle_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: view.setPreviousSong,
                            splashRadius: 24,
                            icon: const Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
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
                                    color: Colors.black.withOpacity(0),
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
                                    !view.player.playing ? Icons.play_arrow_rounded : Icons.pause_rounded,
                                    color: Colors.white,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
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
                            onPressed: () {},
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

  const AudioPlayerPage({Key? key}) : super(key: key);
}
