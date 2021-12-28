import 'package:e_commerce/core/database/cart_database_helper.dart';
import 'package:e_commerce/core/services/firestore_user.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:e_commerce/helper/check_connection.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:e_commerce/helper/toast_maker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartViewModel extends GetxController {
  /* CartViewModel() {
    getAllProduct();
  } */

  /// Signleton Instance of Database
  var databaseHelper = CartDatabaseHelper.instanceOfDatabase;
  final LocalStorageData localStorageData = Get.find();
  //late var userID;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  final List<ProductModel> _cartItemList = [];
  List<ProductModel> get cartItemList => _cartItemList;
  final List<ProductModel> _cartProductList = [];
  List<ProductModel> get cartProductList => _cartProductList;
  double _totalPrice = 0;
  double get totalPrice => _totalPrice;
  final int _productQuantity = 1;
  int? get productQuantity => _productQuantity;
  RefreshController get refreshController => _refreshController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final List<ProductModel> _list1 = [];

  @override
  void onInit() async {
    super.onInit();
    getCurrentUser();
    await mainFun();
    getCartProducts();
    //update();
  } ////Main Methods////

  mainFun() async {
    _list1.clear();
    await HomeServices().getCart().then((value) {
      for (int i = 0; i < value.length; i++) {
        _list1.add(
            ProductModel.fromJson(value[i].data() as Map<String, dynamic>?));
      }
      print("CartProducts = " + _list1.length.toString());
    });
  }

  getCartProducts() async {
    _loading.value = true;
    _cartProductList.clear();
    for (int i = 0; i < _list1.length; i++) {
      _cartProductList.add(_list1[i]);
    }
    print("FetechedProducts = " + _cartProductList.length.toString());
    _loading.value = false;
    update();
  }

  /////// Add specific product to CART //////
  addProduct(ProductModel targetdProduct) async {
    if (await CheckConnection().isInternet()) {
      for (int i = 0; i < _cartProductList.length; i++) {
        if (targetdProduct.productId == _cartProductList[i].productId) {
          ToastMaker().showToast('Item already in the cart');
          return;
        }
      }
      await FireStoreUser().addProductToCart(targetdProduct);
      await mainFun();
      getCartProducts();
    } else {
      ToastMaker().showToast("No Internet Connection");
    }
  }

  ///
  ///
  ///
  //////// Delete products from cart (firebase & sha.p) /////
  deleteProductFromCart(String specificProductId) async {
    if (await CheckConnection().isInternet()) {
      await HomeServices().deleteSpecProductById(specificProductId);
      await mainFun();
      _cartProductList
          .removeWhere((element) => element.productId == specificProductId);
      print("FetechedProducts = " + _cartProductList.length.toString());
      ToastMaker().showToast("Item has been deleted");
      update();
    } else {
      ToastMaker().showToast("No Internet Connection");
    }
    /* _totalPrice -=
        (double.parse(specificProduct.price!) * specificProduct.quantity!); */
  }

  ///
  ///
  ///
  ///
  //// On Refresh Method ////
  /* void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      getAllProduct();
      //getTotalPrice();
    } catch (e) {
      update();
    }
    update();
    _refreshController.refreshCompleted();
  } */

  ///
  ///
  ///
  ///
  void getCurrentUser() async {
    _loading.value = true;
    try {
      await localStorageData.getUser.then((value) {
        _userModel = value!;
      });
    } catch (error) {
      return;
    }
    _loading.value = false;
    update();
  }

  ///
  ///
  ///
  //// Calculate total price
  /* getTotalPrice() {
    print("Products:");
    print(_cartProductList.length);
    for (int i = 0; i < _cartProductList.length; i++) {
      _totalPrice += (double.parse(_cartProductList[i].price!) *
          _cartProductList[i].quantity!);
    }
    print("Price:");
    print(_totalPrice);
    update();
  } */

  /* increaseQuantity(int i) async {
    _cartList[i].quantity = _cartList[i].quantity! + 1;
    _totalPrice += double.parse(_cartList[i].price!);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  }

  decreaseQuantity(int i) async {
    _cartList[i].quantity = _cartList[i].quantity! - 1;
    _totalPrice -= double.parse(_cartList[i].price!);
    await databaseHelper.updateProduct(_cartList[i]);
    update();
  } */

  changeQuantity(String? value, int i) async {
    var quan = int.parse(value!);
    if (quan < _productQuantity) {
      _cartProductList[i].quantity = _cartProductList[i].quantity! - 1;
      _totalPrice -= double.parse(_cartProductList[i].price!);
    }
    if (quan < _productQuantity) {
      _cartProductList[i].quantity = _cartProductList[i].quantity! + 1;
      _totalPrice += double.parse(_cartProductList[i].price!);
    }
    await databaseHelper.updateProduct(_cartProductList[i]);
    update();
  }
}
