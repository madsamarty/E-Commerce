import 'package:cloud_firestore/cloud_firestore.dart';

class HomeServices {
  final CollectionReference _adCollectionRef =
      FirebaseFirestore.instance.collection('Ads');

  final CollectionReference _categoryCollectionRef =
      FirebaseFirestore.instance.collection('Category');

  final CollectionReference _productsCollectionRef =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference _cartProductsCollectionRef =
      FirebaseFirestore.instance.collection('CartProducts');

  Future<List<QueryDocumentSnapshot>> getAds() async {
    var value = await _adCollectionRef.get();
    return value.docs.toList();
  }

  Future<List<QueryDocumentSnapshot>> getAllCategory() async {
    var value = await _categoryCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getSpecCat(
      String targtedCategoryName) async {
    var value = await FirebaseFirestore.instance
        .collection("Products")
        .where('category', isEqualTo: targtedCategoryName)
        .get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getBestSelling() async {
    var value = await _productsCollectionRef.get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getProductById(
      String targetedProductId) async {
    var value = await FirebaseFirestore.instance
        .collection("Products")
        .where('productId', isEqualTo: targetedProductId)
        .get();
    return value.docs;
  }

  Future<void> deleteSpecProduct(String targtedProductId) async {
    DocumentReference documentReference =
        _cartProductsCollectionRef.doc(targtedProductId);
    await documentReference.delete().whenComplete(() => print("Item deleted!"));
  }
}
