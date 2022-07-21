import 'package:flutter/cupertino.dart';
import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/models/search_response.dart';

class SearchListViewModel with ChangeNotifier {
  SearchResponse? _searchData;

  SearchResponse? get searchData => _searchData;

  set searchData(SearchResponse? response) {
    _searchData = response;
    notifyListeners();
  }

  List<SongsDatum>? _searchSongs;

  List<SongsDatum>? get searchSongs => _searchSongs;

  set searchSongs(List<SongsDatum>? response) {
    _searchSongs = response;
    notifyListeners();
  }

  String? _query = "Toofan";

  String? get query => _query;

  set query(String? response) {
    _query = response;
    notifyListeners();
  }

  SearchListViewModel() {
    getResponse();
  }

  Future<void> getResponse() async {
    var response = await ApiService.getData(path: Urls.searchInfo + "$query");
    if (response is Success) {
      var data = searchResponseFromJson((response.data).toString());
      searchData = data;
      searchSongs = searchData?.songs?.data;
    } else if (response is ApiError) {
      print(response.massage);
    }
  }
}
