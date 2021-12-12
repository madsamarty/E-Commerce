import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _cartProductCollection =
      FirebaseFirestore.instance.collection('CartProducts');

  addUserToFireStore(UserModel userModel) async {
    return await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  addProductToCart(CartProductModel cartProductModel) async {
    return await _cartProductCollection
        .doc(cartProductModel.productId)
        .set(cartProductModel.toJson());
  }

  GetCurrentUser(String uid) async {
    return await _userCollection.doc(uid).get();
  }
}
