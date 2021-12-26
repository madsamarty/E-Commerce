import 'package:e_commerce/core/database/cart_database_helper.dart';
import 'package:e_commerce/core/database/wishlist_database_helper.dart';
import 'package:e_commerce/core/services/firestore_user.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WishlistViewModel extends GetxController {
  WishlistViewModel() {
    getWishlistProducts();
  }
  var databaseHelper = WishlistDatabaseHelper.instanceOfDatabase;

  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  final List<UserRelatedItemModel> _wishlistItems = [];
  List<UserRelatedItemModel> get wishlistItems => _wishlistItems;

  final List<ProductModel> _wishlistProducts = [];
  List<ProductModel> get wishlistProducts => _wishlistProducts;

  RefreshController get refreshController => _refreshController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /////// Add specific product to Wishlist //////
  addProductToWishlist(UserRelatedItemModel wishlistItemModel) async {
    saveProductToWishlistLocaly(wishlistItemModel);
    await saveProductToWishlistFireStore(wishlistItemModel);
    getWishlistProducts();
  }

  // Step 1
  // Add Product to cart products list (Locally)
  saveProductToWishlistLocaly(UserRelatedItemModel wishlistItemModel) {
    for (int i = 0; i < _wishlistItems.length; i++) {
      if (_wishlistItems[i].productId == wishlistItemModel.productId) {
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
    databaseHelper.insert(wishlistItemModel);
    _wishlistItems.add(wishlistItemModel);
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
  saveProductToWishlistFireStore(UserRelatedItemModel wishlistItemModel) async {
    UserRelatedItemModel addedWishlistItemModel = UserRelatedItemModel(
      productId: wishlistItemModel.productId,
      userId: wishlistItemModel.userId,
      quantity: 1,
    );
    await FireStoreUser().addProductToWishlist(addedWishlistItemModel);
  }

  /////// Show all products in the cart //////
  void getWishlistProducts() async {
    _wishlistProducts.clear();
    _loading.value = true;
    /*  //put data in cart item model list
    _uriList = await databaseHelper.getCartProducts(); */
    //retrieve data from fire store by id
    if (_wishlistItems.isNotEmpty) {
      for (int i = 0; i < _wishlistItems.length; i++) {
        retrieveProductsDataById(_wishlistItems[i].productId);
      }
    }
    _loading.value = false;
    update();
  }

  // Retrieve products data from firestore to display it in cart view
  retrieveProductsDataById(String cartItemId) async {
    _loading.value = true;
    //var productID = cartItem.productId;
    String itemId = cartItemId.toString();
    await HomeServices().getProductById(itemId).then((value) {
      _wishlistProducts
          .add(ProductModel.fromJson(value[0].data() as Map<String, dynamic>));
      _loading.value = false;
    });
  }

  ///
  ///
  ///
  //////// Delete products from cart (firebase & sha.p) /////
  deleteProductFromWishlist(String specificProductId) async {
    await HomeServices().deleteSpecProductById(specificProductId);
    await databaseHelper.deleteProduct(specificProductId);
    for (int i = 0; i < _wishlistItems.length; i++) {
      if (_wishlistItems[i].productId == specificProductId) {
        _wishlistItems.removeAt(i);

        //print(_cartItemList.length);
        //getAllProduct();
      } else if (_wishlistProducts[i].productId == specificProductId) {
        _wishlistProducts.removeAt(i);
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
      getWishlistProducts();
    } catch (e) {
      update();
    }
    update();
    _refreshController.refreshCompleted();
  }
}
