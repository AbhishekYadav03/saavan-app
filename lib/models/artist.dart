class Artist {
  Artist({
    this.id,
    this.name,
    this.role,
    this.image,
    this.type,
    this.permaUrl,
  });

  String? id;
  String? name;
  String? role;
  String? image;
  String? type;
  String? permaUrl;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        image: json["image"],
        type: json["type"],
        permaUrl: json["perma_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "image": image,
        "type": type,
        "perma_url": permaUrl,
      };
}
