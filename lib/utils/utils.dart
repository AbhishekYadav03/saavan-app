extension CustomExtentions on String {
  String get parseDuration {
    int duration = int.parse(this);
    return "${(duration / 60).floor()}m ${duration % 60}s";
  }

  String get parsePlayerDuration {
    int duration = int.parse(this);
    String m = "${(duration / 60).floor()}";
    String s = "${duration % 60}";
    return "${m.padLeft(2, "0")}:${s.padLeft(2, "0")}";
  }

  String get parseDurationLong {
    int duration = int.parse(this);
    return "${(duration / 60).floor()} Minute ${duration % 60} Seconds";
  }

  String get parseString {
    return replaceAll("&#039;", '\'').replaceAll("&quot;", "\"");
  }

  int get parseInt {
    return int.parse(this);
  }
}

class Utils {
  static const packageId = "com.example.git_app";
}
