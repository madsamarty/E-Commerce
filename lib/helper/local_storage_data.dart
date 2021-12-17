import 'dart:convert';

import 'package:e_commerce/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constance.dart';

class LocalStorageData {
  Future<UserModel?> get getUser async {
    try {
      UserModel? cachedUserModel = await _getUserData();
      if (cachedUserModel == null) {
        print("No User...");
      } else {
        return cachedUserModel;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //// SHARED PREFS ////
  ///
  ///
  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await prefs.getString(CACHED_USER_DATA);
    return UserModel.fromJson(json.decode(user!));
  }

  setUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(CACHED_USER_DATA, json.encode(userModel.toJson()));
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = await prefs.getString('userId').toString();
    return id;
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
