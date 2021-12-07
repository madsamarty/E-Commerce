class AdModel {
  late String title, image, adId;
  AdModel({
    //required this.adId,
    required this.title,
    required this.image,
  });

  AdModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    adId = map['adId'];
    title = map['title'];
    image = map['image'];
  }

  toJson() {
    return {'title': title, 'image': image, 'adId': adId};
  }
}
