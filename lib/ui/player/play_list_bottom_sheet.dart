import 'package:audio_service/audio_service.dart';
import 'package:saavan_app/audio_player/audio_manager.dart';
import 'package:saavan_app/service/service_locator.dart';

import '../imports.dart';

class PlaylistBottomSheet extends StatelessWidget {
  const PlaylistBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MediaItem>>(
        valueListenable: getIt<AudioServiceManager>().playlistNotifier,
        builder: (context, playList, _) {
          return Container(
            padding: const EdgeInsets.only(top: 16),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: playList.length,
                itemBuilder: (BuildContext context, index) {
                  MediaItem song = playList.elementAt(index);
                  // bool isCurrentSong = view.currentSong?.id == song.id;
                  bool isCurrentSong = false;
                  return ListTile(
                    onTap: () {
                      getIt<AudioServiceManager>().skipToIndex(index);
                      Navigator.pop(context);
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: song.artUri?.toString() ?? "",
                      ),
                    ),
                    title: Text(
                      song.title,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: isCurrentSong ? Colors.green : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    subtitle: Text(
                      song.artist?.trim() ?? "",
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: isCurrentSong ? Colors.green.withOpacity(0.7) : Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  );
                },
              ),
            ),
          );
        });
  }
}
