class Genre {
  Genre({
    this.image,
    this.title,
    this.tags,
    this.about,
  });

  String? image;
  String? title;
  String? tags;
  String? about;

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        image: json["image"],
        title: json["title"],
        tags: json["tags"],
        about: json["about"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "title": title,
        "tags": tags,
        "about": about,
      };
}
