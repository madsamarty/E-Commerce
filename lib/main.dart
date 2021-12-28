import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/globals.dart';
import 'helper/binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Binding().dependencies();
  await Firebase.initializeApp();
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
      title: 'Eshtry',
      theme: ThemeData(
          primarySwatch: primaryColorTheme,
          fontFamily: 'Roboto',
          primaryColor: primaryColor),
      home: ControlView(),
    );
  }
}
