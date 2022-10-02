import 'package:flutter/material.dart';
import 'package:saavan_app/data/api_service.dart';
import 'package:saavan_app/data/urls.dart';
import 'package:saavan_app/models/response/api_error.dart';
import 'package:saavan_app/models/response/api_success.dart';
import 'package:saavan_app/ui/imports.dart';

class AlbumInfoViewModel with ChangeNotifier {
  Album? _albumInfo;
  Album? get albumInfo => _albumInfo;

  set albumInfo(Album? val) {
    _albumInfo = val;
    _getTotalDuration();
  }

  String? _copyRightText;
  String? get copyRightText => _copyRightText;

  set copyRightText(String? val) {
    _copyRightText = val;
    notifyListeners();
  }

  Future<void> getAlbumById(String id) async {
    String params = Urls.albumInfo + (id) + Urls.apiVersion + Urls.jsonFormat;
    var response = await ApiService.getData(path: params);
    if (response is Success) {
      var data = albumFromJson((response.data).toString());
      albumInfo = data;
      print("Album songs Count : ${data.song?.length}");
    } else if (response is ApiError) {
      print(response.massage);
    }
  }

  void _getTotalDuration() {
    int duration = 0;
    albumInfo?.song?.forEach((element) {
      duration += element.moreInfo?.duration?.parseInt ?? 0;
    });

    String albumSongs = "${albumInfo?.moreInfo?.songCount ?? 0} Songs - ";
    String copyRightSongs = albumInfo?.moreInfo?.copyrightText ?? "";
    String songsDuration = duration.toString().parseDurationLong + "\n";
    copyRightText = albumSongs + songsDuration + copyRightSongs;
  }

  void reset() {
    albumInfo = null;
    copyRightText = null;
  }
}
