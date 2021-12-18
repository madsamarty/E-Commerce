import 'package:e_commerce/core/database/cart_database_helper.dart';
import 'package:e_commerce/core/services/firestore_user.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartViewModel extends GetxController {
  CartViewModel() {
    getAllProduct();
  }

  /// Signleton Instance of Database
  var databaseHelper = CartDatabaseHelper.instanceOfDatabase;
  final LocalStorageData localStorageData = Get.find();
  //late var userID;
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;
  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;
  List<CartItemModel> _cartItemList = [];
  List<CartItemModel> get cartItemList => _cartItemList;
  final List<ProductModel> _cartProductList = [];
  List<ProductModel> get cartProductList => _cartProductList;
  double _totalPrice = 0;
  double get totalPrice => _totalPrice;
  int _productQuantity = 1;
  int? get productQuantity => _productQuantity;
  RefreshController get refreshController => _refreshController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ////Main Methods////
  ///
  ///
  /////// Add specific product to CART //////
  addProduct(CartItemModel cartProductModel) async {
    //getCurrentUserId();
    await saveProductToCartFireStore(cartProductModel);
    saveProductToCartList(cartProductModel);
    getAllProduct();
  }

  // Step 1
  // Add Product to cart products list (Locally)
  saveProductToCartList(CartItemModel cartProductModel) {
    for (int i = 0; i < _cartItemList.length; i++) {
      if (_cartItemList[i].productId == cartProductModel.productId) {
        Fluttertoast.showToast(
            msg: "Item already in the cart",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    }
    databaseHelper.insert(cartProductModel);
    _cartItemList.add(cartProductModel);
    Fluttertoast.showToast(
        msg: "Item Added!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  // Step 2
  // Add Products to Cart Collection in Firebase Database
  saveProductToCartFireStore(CartItemModel cartProductModel) async {
    CartItemModel addedCartProductModel = CartItemModel(
      productId: cartProductModel.productId,
      userId: cartProductModel.userId,
      quantity: _productQuantity,
    );
    await FireStoreUser().addProductToCart(addedCartProductModel);
  }

  ///
  ///
  ///
  /////// Show all products in the cart //////
  getAllProduct() async {
    _cartProductList.clear();
    _loading.value = true;
    //put data in cart item model list
    _cartItemList = await databaseHelper.getCartProducts();
    //retrieve data from fire store by id
    if (_cartItemList.isNotEmpty) {
      for (int i = 0; i < _cartItemList.length; i++) {
        retrieveProductsDataById(_cartItemList[i].productId);
      }
    }
    getTotalPrice();
    _loading.value = false;
    update();
  }

  // Retrieve products data from firestore to display it in cart view
  retrieveProductsDataById(String cartItemId) async {
    _loading.value = true;
    //var productID = cartItem.productId;
    String itemId = cartItemId.toString();
    await HomeServices().getProductById(itemId).then((value) {
      _cartProductList
          .add(ProductModel.fromJson(value[0].data() as Map<String, dynamic>));
      _loading.value = false;
    });
  }

  ///
  ///
  ///
  //////// Delete products from cart (firebase & sha.p) /////
  deleteProductFromCart(String specificProductId) async {
    await HomeServices().deleteSpecProduct(specificProductId);
    await databaseHelper.deleteProduct(specificProductId);
    for (int i = 0; i < _cartItemList.length; i++) {
      if (_cartItemList[i].productId == specificProductId) {
        _cartItemList.removeAt(i);

        //print(_cartItemList.length);
        //getAllProduct();
      } else if (_cartProductList[i].productId == specificProductId) {
        _cartProductList.removeAt(i);
      }
    }
    update();
    //getAllProduct();
    //_cartList.add(cartProductModel);
    /* _totalPrice -=
        (double.parse(specificProduct.price!) * specificProduct.quantity!); */
  }

  ///
  ///
  ///
  ///
  //// On Refresh Method ////
  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    try {
      getAllProduct();
      getTotalPrice();
    } catch (e) {
      update();
    }
    update();
    _refreshController.refreshCompleted();
  }

  ///
  ///
  ///
  ///
  void getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  ///
  ///
  ///
  //// Calculate total price
  getTotalPrice() {
    print("Products:");
    print(_cartProductList.length);
    for (int i = 0; i < _cartProductList.length; i++) {
      _totalPrice += (double.parse(_cartProductList[i].price!) *
          _cartProductList[i].quantity!);
    }
    print("Price:");
    print(_totalPrice);
    update();
  }

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
