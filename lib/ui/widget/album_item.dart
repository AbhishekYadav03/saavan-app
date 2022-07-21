import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saavan_app/ui/album_info/album_info_page.dart';
import 'package:saavan_app/ui/album_info/album_info_view_model.dart';
import 'package:saavan_app/ui/imports.dart';
import 'package:provider/provider.dart';

class AlbumItem extends StatelessWidget {
  const AlbumItem({Key? key, this.album}) : super(key: key);
  final Album? album;

  @override
  Widget build(BuildContext context) {
    List artist = album?.moreInfo?.artistMap?.artists ?? [];
    String? artistName = artist.isNotEmpty ? album?.moreInfo?.artistMap?.artists?.first.name : null;
    return GestureDetector(
      onTap: () {
        AlbumInfoViewModel viewModel = context.read<AlbumInfoViewModel>();
        viewModel.album = album;
        Navigator.pushNamed(context, AlbumInfoPage.route);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: album?.image ?? "",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  height: 150,
                  width: 150,
                  imageUrl: album?.image ?? "",
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(
                      child: CircularProgressIndicator(value: downloadProgress.progress),
                    );
                  },
                  errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              album?.title ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              artistName ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      ),
    );
  }
}
