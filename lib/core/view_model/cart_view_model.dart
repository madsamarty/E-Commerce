import 'package:e_commerce/core/database/cart_database_helper.dart';
import 'package:e_commerce/core/services/firestore_user.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

class CartViewModel extends GetxController {
  CartViewModel() {
    getAllProduct();
  }

  /// Signleton Instance of Database
  var databaseHelper = CartDatabaseHelper.instanceOfDatabase;

  var userID = AuthViewModel().userID;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProductModel> _cartList = [];
  List<CartProductModel> get cartList => _cartList;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  //// Show all products
  getAllProduct() async {
    _loading.value = true;

    _cartList = await databaseHelper.getAllProducts();

    print(_cartList.length);
    _loading.value = false;
    getTotalPrice();
    update();
  }

  //// Add specific product to CART ////
  addProduct(CartProductModel cartProductModel) async {
    await saveProductToCartFireStore(cartProductModel);
    saveProductToCartList(cartProductModel);
    update();
  }

  // Step 1
  // Add Product to cart products list (Locally)
  saveProductToCartList(CartProductModel cartProductModel) {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].productId == cartProductModel.productId) {
        return;
      }
    }
    _cartList.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price) * cartProductModel.quantity);
  }

  // Step 2
  // Add Products to Cart Collection in Firebase Database
  saveProductToCartFireStore(CartProductModel cartProductModel) async {
    CartProductModel addedCartProductModel = CartProductModel(
      productId: cartProductModel.productId,
      userId: userID,
      name: cartProductModel.name,
      dis: cartProductModel.dis,
      image: cartProductModel.image,
      price: cartProductModel.price,
      quantity: 1,
    );
    await FireStoreUser().addProductToCart(addedCartProductModel);
  }

  deleteProduct(CartProductModel specificProduct) async {
    String productID = specificProduct.productId!;
    await HomeServices().deleteSpecProduct(productID);
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].productId == specificProduct.productId) {
        _cartList.removeAt(i);
      }
    }
    //_cartList.add(cartProductModel);
    _totalPrice -=
        (double.parse(specificProduct.price) * specificProduct.quantity);
    update();
  }

  //// Calculate total price
  getTotalPrice() {
    for (int i = 0; i < _cartList.length; i++) {
      _totalPrice += (double.parse(_cartList[i].price) * _cartList[i].quantity);
    }
    print(_totalPrice);
    update();
  }

  increaseQuantity(int i) async {
    _cartList[i].quantity = _cartList[i].quantity + 1;
    _totalPrice += double.parse(_cartList[i].price);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  }

  decreaseQuantity(int i) async {
    _cartList[i].quantity = _cartList[i].quantity - 1;
    _totalPrice -= double.parse(_cartList[i].price);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  }
}
