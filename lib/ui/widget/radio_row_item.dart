import 'package:flutter/material.dart';
import 'package:saavan_app/models/genre.dart';

class RadioRowItem extends StatelessWidget {
  const RadioRowItem({Key? key, this.genre}) : super(key: key);
  final Genre? genre;

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
          Stack(
            children: [
              ClipRRect(
                child: Image(
                  height: 100,
                  width: 100,
                  image: NetworkImage(
                    genre?.image ??
                        "https://c.saavncdn.com/editorial/BhajanSagar_saavn_radio_20211129080622_150x150.jpg",
                  ),
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            genre?.title ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            genre?.tags != null ? "${genre?.tags} Songs" : "",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
