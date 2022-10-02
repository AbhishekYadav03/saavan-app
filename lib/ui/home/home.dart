import 'package:saavan_app/ui/imports.dart';
import 'package:saavan_app/ui/search/search_page.dart';
import 'package:saavan_app/ui/widget/mini_player.dart';

class HomePage extends StatelessWidget {
  static const String route = "HomePage";

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: context.read<HomeViewModel>().onRefresh,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SearchPage.route);
                        },
                        child: Hero(
                          tag: "SearchBar",
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                const Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  "Search",
                                  style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Music",
                                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.black),
                              ),
                              Container(
                                height: 4,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl: "https://c.saavncdn.com/artists/Arijit_Singh_150x150.jpg",
                              height: 48,
                              progressIndicatorBuilder: (context, url, downloadProgress) {
                                return Center(
                                  child: CircularProgressIndicator(value: downloadProgress.progress),
                                );
                              },
                              errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<HomeViewModel>(builder: (context, homeView, _) {
                    return AlbumGrid(
                      title: "New Releases",
                      albums: homeView.albums ?? [],
                    );
                  }),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: TopCharts(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<HomeViewModel>(builder: (context, homeView, _) {
                    return AlbumGrid(
                      title: "Trending Now",
                      albums: homeView.trendingAlbums ?? [],
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<HomeViewModel>(builder: (context, homeView, _) {
                    return PlayListRow(
                      title: "Editorial Picks",
                      playList: homeView.featuredList,
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Consumer<HomeViewModel>(builder: (context, homeView, _) {
                    return RadioRow(
                      title: "Radio Stations",
                      genres: homeView.genresList,
                    );
                  }),
                ),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: ArtistRow(
                    title: "Recommended Artist Radio",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: const MiniPlayer(),
    );
  }
}
