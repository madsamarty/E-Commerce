import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/user_model.dart';

class FireStoreUser{
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('Users');

  addUserToFireStore(UserModel userModel) async {
    return await _userCollection.doc(userModel.userId).set(userModel.toJson());
  }
}