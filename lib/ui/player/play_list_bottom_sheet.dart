import '../imports.dart';

class PlaylistBottomSheet extends StatelessWidget {
  const PlaylistBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayerPageViewModel>(builder: (context, view, _) {
      return Container(
        padding: const EdgeInsets.only(top: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: view.songs.length,
            itemBuilder: (BuildContext context, index) {
              Song song = view.songs.elementAt(index);
              bool isCurrentSong = view.currentSong?.id == song.id;
              return ListTile(
                onTap: () {
                  if (!isCurrentSong) {
                    view.setIndexSong(index);
                  }
                  Navigator.pop(context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: song.image ?? "",
                  ),
                ),
                title: Text(
                  song.title ?? "",
                  maxLines: 1,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: isCurrentSong ? Colors.green : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                subtitle: Text(
                  song.artistsName?.trim() ?? "",
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
