import 'package:flutter/material.dart';

class ArtistRowItem extends StatelessWidget {
  const ArtistRowItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: const Image(
              height: 100,
              width: 100,
              image: NetworkImage(
                "https://c.saavncdn.com/artists/Arijit_Singh_150x150.jpg",
              ),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          const SizedBox(height: 8),
          Text(
            "Arijit Singh",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "Artist Radio",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
