import 'package:e_commerce/helper/check_connection.dart';
import 'package:e_commerce/core/services/firestore_user.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:e_commerce/helper/toast_maker.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:e_commerce/view/app/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:connectivity/connectivity.dart';

class AuthViewModel extends GetxController {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  late TextEditingController emailController,
      passwordController,
      nameController;
  late String email = "", password = "", name = "";

  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  final Rxn<User> _user = Rxn<User>();
  String? get user => _user.value?.email;

  final LocalStorageData localStorageData = Get.find();

  String get userID => _userID;
  String _userID = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();

    //getCurrentUserData(_auth.currentUser!.uid);

    _user.bindStream(_auth.authStateChanges());
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    if (await CheckConnection().isInternet()) {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await _auth.signInWithCredential(credential).then((user) {
          saveUser(user);
          Get.offAll(ControlView());
        });
      }
    } else {
      ToastMaker().showSnackBar("No Internet Connection");
    }
  }

  void facebookSignInMethod() async {
    LoginResult result =
        await _facebookAuth.login(permissions: const ['email']);

    final accessToken = result.accessToken!.token;

    if (result.status == LoginStatus.success) {
      try {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken);
        await _auth
            .signInWithCredential(credential)
            .then((user) => {saveUser(user)});
        Get.offAll(() => HomeView());
      } catch (error) {
        Get.snackbar("Error login to Facebook account", error.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  void signInWithEmailAndPassword() async {
    _loading.value = true;
    if (await CheckConnection().isInternet()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) async {
          getCurrentUserData(value.user!.uid);
          _userID = value.user!.uid;
        });
        if (_loading.value) {
          Get.offAll(() => ControlView());
        }
      } catch (error) {
        ToastMaker().showSnackBarWithError(
            "Error login to Google account", error.toString());
      }
    } else {
      ToastMaker().showSnackBar("No Internet Connection");
    }
  }

  void createAccountWithEmailAndPassword() async {
    if (await CheckConnection().isInternet()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((user) => {saveUser(user)});
        Get.offAll(() => ControlView());
      } catch (error) {
        //print(error);
        Get.snackbar("Error register account", error.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      ToastMaker().showSnackBar("No Internet Connection");
    }
  }

  // Save user data for the first time in firebase
  // Sign up method
  void saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
        userId: user.user!.uid,
        email: user.user!.email!,
        name: name,
        /*name == null ? user.user!.displayName : name,*/
        pic:
            "https://firebasestorage.googleapis.com/v0/b/e-commerce-bbf5d.appspot.com/o/120.png?alt=media&token=7fbb8ba7-8451-4fe7-85eb-8afe850f95d7");
    await FireStoreUser().addUserToFireStore(userModel);
    setUser(userModel);
    //_userID = userModel.userId;
  }

  // Get user data from firebase
  void getCurrentUserData(String uid) async {
    await FireStoreUser().GetCurrentUser(uid).then((value) {
      setUser(UserModel.fromJson(value.data()));
    });
  }

  // Save user in Local Database
  // Shared Prefs
  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
    _loading.value = false;
  }

  //// Validation ////

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }
}
