class ItemModel {
  final String? id;
  final String? name;
  final String? image;
  final String? availability;
  ItemModel({
    required this.id,
    required this.name,
    required this.availability,
    required this.image,
  });
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json["id"],
      name: json["name"],
      availability: json["availability"],
      image: json["image_url"] ?? json["image"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "availability": availability,
      "image": image,
    };
  }
}
