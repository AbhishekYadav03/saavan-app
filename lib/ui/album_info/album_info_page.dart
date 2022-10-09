import 'package:saavan_app/audio_player/audio_manager.dart';
import 'package:saavan_app/service/service_locator.dart';
import 'package:saavan_app/ui/imports.dart';
import 'package:saavan_app/ui/widget/mini_player.dart';

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
                            tag: viewModel.albumInfo?.id ?? "",
                            child: (viewModel.albumInfo?.image ?? "") == ""
                                ? const SizedBox()
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      height: 200,
                                      width: 200,
                                      imageUrl: viewModel.albumInfo?.image ?? "",
                                      fit: BoxFit.contain,
                                      progressIndicatorBuilder: (context, url, downloadProgress) {
                                        return Center(
                                          child: CircularProgressIndicator(value: downloadProgress.progress),
                                        );
                                      },
                                      errorWidget: (context, url, error) =>
                                          const Center(child: Icon(Icons.error)),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          viewModel.albumInfo?.title?.parseString ?? "",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          viewModel.albumInfo?.headerDesc != null ? viewModel.albumInfo?.headerDesc ?? "" : "-",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Text(
                          viewModel.albumInfo?.playCount != null ? viewModel.albumInfo?.playCount ?? "" : "-",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (viewModel.albumInfo?.song?.isNotEmpty == true)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.albumInfo?.song?.length ?? 0,
                          itemBuilder: (_, index) {
                            Song? song = viewModel.albumInfo?.song?.elementAt(index);
                            return ListTile(
                              title: Text(
                                song?.title?.parseString ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                song?.artistsName ?? "",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              onTap: () {
                                // var view = context.read<AudioPlayerPageViewModel>();
                                // view.songs = viewModel.albumInfo?.song ?? [];
                                // view.currentIndex = index;

                                // getIt<DemoPlaylist>().songs= viewModel.albumInfo?.song ?? [];
                                getIt<AudioServiceManager>().startPlayback(viewModel.albumInfo?.song ?? []);

                                Navigator.pushNamed(context, AudioPlayerPage.route);
                              },
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(song?.moreInfo?.duration?.parseDuration ?? ''),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.download_sharp),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      if (viewModel.albumInfo?.song?.isNotEmpty == true)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 64),
                          child: Text(
                            viewModel.albumInfo?.moreInfo?.copyrightText != null
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
      bottomSheet: const MiniPlayer(),
    );
  }
}
