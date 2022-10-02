import 'dart:async';

import 'package:saavan_app/models/artist.dart';
import 'package:saavan_app/models/show.dart';
import 'package:saavan_app/ui/imports.dart';

class SearchPage extends StatelessWidget {
  static const String route = "SearchPage";

  const SearchPage({Key? key}) : super(key: key);
  static Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 16, right: 16),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Hero(
                            tag: "SearchBar",
                            child: Material(
                              child: TextFormField(
                                initialValue: context.read<SearchListViewModel>().query,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Search',
                                  fillColor: Colors.grey.withOpacity(0.1),
                                  filled: true,
                                ),
                                autofocus: true,
                                onFieldSubmitted: (String str) {
                                  context.read<SearchListViewModel>().getResponse();
                                },
                                onChanged: (String value) {
                                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                                  _debounce = Timer(const Duration(milliseconds: 500), () {
                                    context.read<SearchListViewModel>().query = value.trim();
                                    context.read<SearchListViewModel>().getResponse();
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Consumer<SearchListViewModel>(
                          builder: (context, vi, _) {
                            return Column(
                              children: [
                                if ((vi.searchData?.albums?.data.length ?? 0) > 0)
                                  Text("Albums", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.albums?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    Album? data = vi.searchData?.albums?.data.elementAt(index);
                                    return ListTile(
                                      onTap: () {
                                        AlbumInfoViewModel viewModel = context.read<AlbumInfoViewModel>();
                                        viewModel.getAlbumById(data?.id ?? "");
                                        Navigator.pushNamed(context, AlbumInfoPage.route);
                                      },
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.moreInfo?.music?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.songs?.data.length ?? 0) > 0)
                                  Text("Songs", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchSongs?.length ?? 0,
                                  itemBuilder: (_, index) {
                                    Song? data = vi.searchSongs![index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data.image ?? ""),
                                      ),
                                      title: Text(data.title ?? ""),
                                      subtitle: Text(data.moreInfo?.album?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.playlists?.data.length ?? 0) > 0)
                                  Text("Playlists", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.playlists?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    PlaylistInfo? data = vi.searchData?.playlists?.data.elementAt(index);

                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.description?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.artists?.data.length ?? 0) > 0)
                                  Text("Artists", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.artists?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    Artist? data = vi.searchData?.artists?.data.elementAt(index);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.description?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.topQuery?.data.length ?? 0) > 0)
                                  Text("Top Query", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.topQuery?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    Song? data = vi.searchData?.topQuery?.data.elementAt(index);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.type?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.shows?.data.length ?? 0) > 0)
                                  Text("Shows", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.shows?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    Show? data = vi.searchData?.shows?.data.elementAt(index);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.description?.toString() ?? ""),
                                    );
                                  },
                                ),
                                if ((vi.searchData?.episodes?.data.length ?? 0) > 0)
                                  Text("Episodes", style: Theme.of(context).textTheme.titleLarge),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: vi.searchData?.episodes?.data.length ?? 0,
                                  itemBuilder: (_, index) {
                                    var data = vi.searchData?.episodes?.data.elementAt(index);
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(data?.image ?? ""),
                                      ),
                                      title: Text(data?.title ?? ""),
                                      subtitle: Text(data?.moreInfo?.songCount?.toString() ?? ""),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
