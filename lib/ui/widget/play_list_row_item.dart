import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saavan_app/ui/imports.dart';

class PlayListRowItem extends StatelessWidget {
  const PlayListRowItem({Key? key, this.playlistInfo}) : super(key: key);
  final PlaylistInfo? playlistInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image(
              height: 99,
              width: 99,
              image: NetworkImage(
                playlistInfo?.image ??
                    "https://c.saavncdn.com/editorial/ShreyaKeSur_20220714144331_150x150.jpg",
              ),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          const SizedBox(height: 8),
          Text(
            playlistInfo?.title ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            playlistInfo?.moreInfo?.followerCount ?? "",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
