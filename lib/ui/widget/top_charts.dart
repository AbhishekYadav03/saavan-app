import 'package:flutter/material.dart';
import 'package:git_app/models/chart.dart';
import 'package:git_app/ui/home/home_view_model.dart';
import 'package:git_app/ui/widget/play_list_item.dart';
import 'package:provider/provider.dart';

class TopCharts extends StatelessWidget {
  const TopCharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Top Charts",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: Colors.black),
            ),
          ),
          Consumer<HomeViewModel>(builder: (context, homeView, _) {
            return IntrinsicHeight(
              child: SizedBox(
                height: 320,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              const Image(
                                image: NetworkImage(
                                  "https://c.saavncdn.com/editorial/wt15-49_20220715122650_500x500.jpg",
                                ),
                                height: 180,
                              ),
                              const SizedBox(height: 32),
                              Text(
                                "Weekly Top Songs",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 8),
                                child: Text(
                                  "The top movers this week, from our editors.",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 180,
                            childAspectRatio: 2 / 2,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeView.topCharts?.length ?? 0,
                          itemBuilder: (_, index) {
                            Chart? chart = homeView.topCharts?.elementAt(index);
                            return PLayListItem(
                              chart: chart,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
