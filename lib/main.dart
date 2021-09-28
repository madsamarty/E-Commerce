//import 'package:e_commerce/view/auth/register_view.dart';
import 'package:e_commerce/view/auth/register_view.dart';
import 'package:e_commerce/view/auth/welcom.dart';
import 'package:e_commerce/view/control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'helper/binding.dart';
import 'view/auth/login_view.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      //initialRoute: '/Login',
      //getPages: _getPages(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ControlView(),
    );
  }
}
