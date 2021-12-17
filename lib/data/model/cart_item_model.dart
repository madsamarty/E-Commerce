import 'package:e_commerce/helper/extenstion.dart';
import 'package:flutter/material.dart';

class CartItemModel {
  late String userId;
  late String productId;
  late int? quantity;

  CartItemModel({
    this.userId = "",
    required this.productId,
    required this.quantity,
  });

  CartItemModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    productId = map['productId'];
    quantity = map['quantity'];
  }

  toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'quantity': quantity,
    };
  }
}
