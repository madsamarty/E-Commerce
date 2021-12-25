import 'package:e_commerce/helper/extenstion.dart';
import 'package:flutter/material.dart';

class UserRelatedItemModel {
  late String userId;
  late String productId;
  late int? quantity;

  UserRelatedItemModel({
    this.userId = "",
    required this.productId,
    required this.quantity,
  });

  UserRelatedItemModel.fromJson(Map<String, dynamic>? map) {
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
