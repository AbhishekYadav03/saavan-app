import 'dart:convert';

SongUrl songUrlFromJson(String str) => SongUrl.fromJson(json.decode(str));

String songUrlToJson(SongUrl data) => json.encode(data.toJson());

class SongUrl {
  String? authUrl;
  String? type;
  String? status;

  SongUrl({this.authUrl, this.type, this.status});

  SongUrl.fromJson(Map<String, dynamic> json) {
    authUrl = json['auth_url'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['auth_url'] = authUrl;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}
