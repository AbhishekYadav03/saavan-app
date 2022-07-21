import 'package:flutter/material.dart';
import 'package:git_app/ui/imports.dart';

class PLayListItem extends StatelessWidget {
  const PLayListItem({Key? key, required this.chart}) : super(key: key);
  final Chart? chart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                chart?.image ??
                    "https://sdlhivkecdnems05.cdnsrv.jio.com/c.saavncdn.com/editorial/wt15-49_20220715122650_500x500.jpg",
              ),
              width: 150,
              height: 90,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 8),
          Text(
            chart?.title ?? "",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            chart?.moreInfo?.firstname ?? "",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
