import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class FireStoreUser {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _cartProductCollection =
      FirebaseFirestore.instance.collection('CartProducts');
  final CollectionReference _wishlistCollection =
      FirebaseFirestore.instance.collection('Wishlist');

  addUserToFireStore(UserModel userModel) async {
    return await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  /* getCartProductsOnline() async {
    return await _cartProductCollection
        .doc(cartProductModel.productId)
        .set(cartProductModel.toJson());
  } */

  addProductToCart(ProductModel cartProductModel) async {
    return await _cartProductCollection
        .doc(cartProductModel.productId)
        .set(cartProductModel.toJson())
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Item Added!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0)
            });
  }

  addProductToWishlist(UserRelatedItemModel wishlistItemModel) async {
    return await _wishlistCollection
        .doc(wishlistItemModel.productId)
        .set(wishlistItemModel.toJson());
  }

  GetCurrentUser(String uid) async {
    return await _userCollection.doc(uid).get();
  }

  /* GetCurrentUserId() async {
    return await _userCollection.doc().get()
  } */
}
