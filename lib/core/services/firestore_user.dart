import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/model/user_model.dart';

class FireStoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _cartProductCollection =
      FirebaseFirestore.instance.collection('CartProducts');

  addUserToFireStore(UserModel userModel) async {
    return await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  /* getCartProductsOnline() async {
    return await _cartProductCollection
        .doc(cartProductModel.productId)
        .set(cartProductModel.toJson());
  } */

  addProductToCart(CartItemModel cartProductModel) async {
    return await _cartProductCollection
        .doc(cartProductModel.productId)
        .set(cartProductModel.toJson());
  }

  GetCurrentUser(String uid) async {
    return await _userCollection.doc(uid).get();
  }

  /* GetCurrentUserId() async {
    return await _userCollection.doc().get()
  } */
}
