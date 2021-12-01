import 'package:e_commerce/helper/extenstion.dart';
import 'package:flutter/material.dart';

class ProductByCategoryModel {
  late String name, productId, category, image, price, dis, size;
  late Color color;
  ProductByCategoryModel({required this.name, required this.image});

  ProductByCategoryModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    productId = map['productId'];
    name = map['name'];
    category = map['category'];
    image = map['image'];
    dis = map['dis'];
    price = map['price'];
    color = HexColor.fromHex(map['color']);
    size = map['size'];
  }

  toJson() {
    return {
      'productId': productId,
      'name': name,
      'category': category,
      'image': image,
      'dis': dis,
      'price': price,
      'color': color,
      'size': size,
    };
  }
}
