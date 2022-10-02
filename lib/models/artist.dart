class Artist {
  Artist({
    this.id,
    this.name,
    this.title,
    this.extra,
    this.miniObj,
    this.isRadioPresent,
    this.ctr,
    this.entity,
    this.description,
    this.position,
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
  String? title;
  String? extra;
  bool? miniObj;
  bool? isRadioPresent;
  int? ctr;
  int? entity;
  String? description;
  int? position;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        id: json["id"],
        name: json["name"],
        role: json["role"],
        image: json["image"],
        type: json["type"],
        permaUrl: json["perma_url"],
        title: json["title"],
        extra: json["extra"],
        miniObj: json["mini_obj"],
        isRadioPresent: json["isRadioPresent"],
        ctr: json["ctr"],
        entity: json["entity"],
        description: json["description"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "role": role,
        "image": image,
        "type": type,
        "perma_url": permaUrl,
        "title": title,
        "extra": extra,
        "mini_obj": miniObj,
        "isRadioPresent": isRadioPresent,
        "ctr": ctr,
        "entity": entity,
        "description": description,
        "position": position,
      };
}
