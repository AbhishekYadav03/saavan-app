import 'package:saavan_app/ui/imports.dart';

class AlbumInfoPage extends StatelessWidget {
  static const String route = "AlbumInfoPage";

  const AlbumInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<AlbumInfoViewModel>(
        builder: (context, viewModel, _) {
          return WillPopScope(
            onWillPop: () async {
              viewModel.reset();
              return true;
            },
            child: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Hero(
                            tag: viewModel.album?.image ?? "",
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                height: 200,
                                width: 200,
                                imageUrl: viewModel.album?.image ?? "",
                                fit: BoxFit.contain,
                                progressIndicatorBuilder: (context, url, downloadProgress) {
                                  print(downloadProgress.originalUrl);
                                  return Center(
                                    child: CircularProgressIndicator(value: downloadProgress.progress),
                                  );
                                },
                                errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          viewModel.album?.title ?? "",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          viewModel.albumInfo?.primaryArtists != null
                              ? "by ${viewModel.albumInfo?.primaryArtists ?? ""}"
                              : "-",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          viewModel.album?.playCount != null ? viewModel.album?.playCount ?? "" : "-",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (viewModel.albumInfo?.primaryArtists != null)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.albumInfo?.songs.length ?? 0,
                          itemBuilder: (_, index) {
                            Song? song = viewModel.albumInfo?.songs.elementAt(index);
                            return ListTile(
                              title: Text(
                                song?.song?.parseString ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                song?.primaryArtists ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(song?.duration?.parseDuration ?? ''),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.download_sharp),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (viewModel.albumInfo?.songs.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 64),
                          child: Text(
                            viewModel.albumInfo?.songs.first.copyrightText != null
                                ? viewModel.copyRightText ?? ""
                                : "-",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
