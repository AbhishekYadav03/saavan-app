extension CutomExtentions on String {
  String get parseDuration {
    int duration = int.parse(this);
    return "${(duration / 60).floor()}m ${duration % 60}s";
  }

  String get parseString {
    String str = this;
    return (str.replaceAll("&quot;", "\""));
  }

  int get parseInt {
    return int.parse(this);
  }
}

class Utils {}
