//import 'package:e_commerce/view/auth/register_view.dart';
import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'globals.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Binding().dependencies();
  await Firebase.initializeApp();
  //Get.put(CartViewModel());
  //Get.put(ProfileViewModel());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: snackbarKey,
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      //initialRoute: '/Login',
      //getPages: _getPages(),
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: primaryColorTheme, fontFamily: 'Roboto'),
      home: ControlView(),
    );
  }
}
