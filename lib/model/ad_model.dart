class AdModel {
  late String title, image;
  AdModel({
    required this.title,
    required this.image,
  });

  AdModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    title = map['title'];
    image = map['image'];
  }

  toJson() {
    return {'title': title, 'image': image};
  }
}
