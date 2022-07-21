import 'package:flutter/material.dart';
import 'package:saavan_app/ui/imports.dart';
import 'package:saavan_app/ui/widget/album_item.dart';

class AlbumGrid extends StatelessWidget {
  const AlbumGrid({Key? key, this.title, required this.albums})
      : super(key: key);
  final String? title;
  final List<Album> albums;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            title ?? "",
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 400,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2.5 / 2,
                  ),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: albums.length,
                  itemBuilder: (_, index) {
                    return AlbumItem(
                      album: albums[index],
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
