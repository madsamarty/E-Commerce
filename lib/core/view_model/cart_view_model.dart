import 'package:e_commerce/core/database/cart_database_helper.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';

class CartViewModel extends GetxController {
  CartViewModel() {
    getAllProduct();
  }

  /// Signleton Instance of Database
  var databaseHelper = CartDatabaseHelper.instanceOfDatabase;

  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  List<CartProductModel> _cartList = [];
  List<CartProductModel> get cartList => _cartList;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  getAllProduct() async {
    _loading.value = true;

    _cartList = await databaseHelper.getAllProducts();

    print(_cartList.length);
    _loading.value = false;
    getTotalPrice();
    update();
  }

  getTotalPrice() {
    for (int i = 0; i < _cartList.length; i++) {
      _totalPrice += (double.parse(_cartList[i].price) * _cartList[i].quantity);
    }
    print(_totalPrice);
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    for (int i = 0; i < _cartList.length; i++) {
      if (_cartList[i].productId == cartProductModel.productId) {
        return;
      }
    }

    await databaseHelper.insert(cartProductModel);
    _cartList.add(cartProductModel);
    _totalPrice +=
        (double.parse(cartProductModel.price) * cartProductModel.quantity);
    update();
  }

  increaseQuantity(int i) async {
    _cartList[i].quantity++;
    _totalPrice += double.parse(_cartList[i].price);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  }

  decreaseQuantity(int i) async {
    _cartList[i].quantity--;
    _totalPrice -= double.parse(_cartList[i].price);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  }
}
