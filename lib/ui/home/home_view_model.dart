/*api.php?__call=content.getHomepageData*/

import 'package:flutter/material.dart';
import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/home_data.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/ui/imports.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel() {
    getHomeData();
    getTrendingData();
  }

  List<Album>? _albums;
  List<Album>? get albums => _albums;
  set albums(List<Album>? val) {
    _albums = val;
    notifyListeners();
  }

  List<Album>? _trendingAlbums;
  List<Album>? get trendingAlbums => _trendingAlbums;

  set trendingAlbums(List<Album>? val) {
    _trendingAlbums = val;
    notifyListeners();
  }

  List<PlaylistInfo>? _featuredList;
  List<PlaylistInfo>? get featuredList => _featuredList;

  set featuredList(List<PlaylistInfo>? val) {
    _featuredList = val;
    notifyListeners();
  }

  List<Genre>? _genresList;
  List<Genre>? get genresList => _genresList;

  set genresList(List<Genre>? val) {
    _genresList = val;
    notifyListeners();
  }

  List<Chart>? _topCharts;
  List<Chart>? get topCharts => _topCharts;

  set topCharts(List<Chart>? val) {
    _topCharts = val;
    notifyListeners();
  }

  Future<void> getHomeData() async {
    var response = await ApiService.getData(path: Urls.homeData);
    if (response is Success) {
      var data = homeDataFromJson((response.data).toString());
      albums = data.albums;
      topCharts = data.charts;
      featuredList = data.featuredPlaylists;
      genresList = data.genres;
    } else if (response is ApiError) {
      print(response.massage);
    }
  }

  Future<void> getTrendingData() async {
    var response = await ApiService.getData(path: Urls.trending);
    if (response is Success) {
      var data = albumsFromJson((response.data).toString());
      print("Trending length: ${data.length}");
      trendingAlbums = data;
    } else if (response is ApiError) {
      print(response.massage);
    }
  }
}
