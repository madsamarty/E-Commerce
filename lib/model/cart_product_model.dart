class CartProductModel {
  late String? name, image, productId, userId, dis;
  late String price;
  late int quantity;

  CartProductModel({
    required this.name,
    this.dis = "",
    required this.image,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.userId,
  });

  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    productId = map['productId'];
    userId = map['userId'];
    name = map['name'];
    image = map['image'];
    price = map['price'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'productId': productId,
      'userId': productId,
      'name': name,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }
}
