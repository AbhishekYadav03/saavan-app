import 'package:flutter/material.dart';
import 'package:git_app/models/genre.dart';
import 'package:git_app/ui/widget/radio_row_item.dart';

class RadioRow extends StatelessWidget {
  const RadioRow({Key? key, this.title, this.genres}) : super(key: key);
  final String? title;
  final List<Genre>? genres;

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
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: genres?.length ?? 0,
                  itemBuilder: (_, index) {
                    return RadioRowItem(
                      genre: genres?.elementAt(index),
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
