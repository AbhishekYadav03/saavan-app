import 'package:flutter/material.dart';
import 'package:git_app/ui/imports.dart';
import 'package:git_app/ui/widget/play_list_row_item.dart';

class PlayListRow extends StatelessWidget {
  const PlayListRow({Key? key, this.title, this.playList}) : super(key: key);
  final String? title;
  final List<PlaylistInfo>? playList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title ?? "",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: playList?.length ?? 0,
                  itemBuilder: (_, index) {
                    return PlayListRowItem(
                      playlistInfo: playList?.elementAt(index),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
