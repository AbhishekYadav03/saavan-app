import 'package:flutter/material.dart';

import 'package:saavan_app/models/search_response.dart';
import 'package:saavan_app/ui/search/search_page_view_model.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.read<SearchListViewModel>();

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search Songs',
                ),
                onFieldSubmitted: (String str) {
                  viewModel.getResponse();
                },
                onChanged: (String value) {
                  viewModel.query = value;
                },
              ),
            ),
            RefreshIndicator(
              onRefresh: () async {
                viewModel.getResponse();
              },
              child: Consumer<SearchListViewModel>(
                builder: (context, vi, _) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: vi.searchSongs?.length ?? 0,
                    itemBuilder: (_, index) {
                      SongsDatum? data = vi.searchSongs![index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(data.image ?? ""),
                        ),
                        title: Text(data.title ?? ""),
                        subtitle: Text(data.moreInfo?.album.toString() ?? ""),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
