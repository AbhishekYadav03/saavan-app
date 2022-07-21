import 'package:git_app/models/bitrate.dart';

class StreamConfig {
  StreamConfig({
    this.availableBitrates,
    this.bitratesMap,
    this.bitrate,
  });

  List<String>? availableBitrates;
  Map<String, BitratesMap>? bitratesMap;
  Bitrate? bitrate;

  factory StreamConfig.fromJson(Map<String, dynamic> json) => StreamConfig(
        availableBitrates:
            List<String>.from(json["available_bitrates"].map((x) => x)),
        bitratesMap: Map.from(json["bitrates_map"]).map((k, v) =>
            MapEntry<String, BitratesMap>(k, BitratesMap.fromJson(v))),
        bitrate: Bitrate.fromJson(json["bitrate"]),
      );

  Map<String, dynamic> toJson() => {
        "available_bitrates": availableBitrates != null
            ? List<dynamic>.from(availableBitrates!.map((x) => x))
            : null,
        "bitrates_map": bitratesMap != null
            ? Map.from(bitratesMap!)
                .map((k, v) => MapEntry<String, dynamic>(k, v.toJson()))
            : null,
        "bitrate": bitrate?.toJson(),
      };
}
