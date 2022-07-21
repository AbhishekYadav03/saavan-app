import 'package:flutter/material.dart';
import 'package:git_app/data/api_service.dart';
import 'package:git_app/data/urls.dart';
import 'package:git_app/models/album_info.dart';
import 'package:git_app/models/response/api_error.dart';
import 'package:git_app/models/response/api_success.dart';
import 'package:git_app/ui/imports.dart';

class AlbumInfoViewModel with ChangeNotifier {
  Album? _album;

  Album? get album => _album;

  set album(Album? val) {
    _album = val;
    getAlbumById();
  }

  AlbumInfo? _albumInfo;

  AlbumInfo? get albumInfo => _albumInfo;

  set albumInfo(AlbumInfo? val) {
    _albumInfo = val;
    _getTotalDuration();
  }

  String? _copyRightText;
  String? get copyRightText => _copyRightText;

  set copyRightText(String? val) {
    _copyRightText = val;
    notifyListeners();
  }

  Future<void> getAlbumById() async {
    String params = Urls.albumInfo + (album?.id ?? "") + Urls.jsonFormat;
    var response = await ApiService.getData(
      path: params,
    );
    if (response is Success) {
      var data = albumInfoFromJson((response.data).toString());
      albumInfo = data;
      print("Album songs Count : ${data.songs.length}");
    } else if (response is ApiError) {
      print(response.massage);
    }
  }

  void _getTotalDuration() {
    int duration = 0;
    albumInfo?.songs.forEach((element) {
      duration += element.duration?.parseInt ?? 0;
    });

    String albumSongs = "${albumInfo?.songs.length ?? 0} Songs - ";
    String copyRightSongs = albumInfo?.songs.first.copyrightText ?? "";
    String songsDuration = duration.toString().parseDuration + "\n";
    copyRightText = albumSongs + songsDuration + copyRightSongs;
  }

  void reset() {
    album = null;
    albumInfo = null;
    copyRightText = null;
  }
}
