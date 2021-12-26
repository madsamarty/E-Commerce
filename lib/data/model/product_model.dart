import 'package:e_commerce/helper/extenstion.dart';
import 'package:flutter/material.dart';

class ProductModel {
  late String? name, category, image, dis, productId, userId;
  late String? price;
  late int? quantity;

  ProductModel({
    required this.productId,
    this.userId = "",
    this.quantity = 0,
    required this.name,
    required this.image,
    required this.category,
    required this.dis,
    required this.price,
  });

  ProductModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    productId = map['productId'];
    userId = map['userId'];
    name = map['name'];
    category = map['category'];
    image = map['image'];
    dis = map['dis'];
    price = map['price'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'productId': productId,
      'userId': userId,
      'name': name,
      'category': category,
      'image': image,
      'dis': dis,
      'price': price,
      'quantity': quantity,
    };
  }
}
