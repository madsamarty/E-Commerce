import 'package:flutter/material.dart';

const String tableProduct = "cartProduct";
const String tableCartProduct = "cartListProduct";
const String columnId = "productId";
const String columnIdUser = "userId";
const String columnName = "name";
const String columnImage = "image";
const String columnPrice = "price";
const String columnQuantity = "quantity";

//const primaryColor = Color.fromRGBO(0, 197, 105, 1.0);
const Color primaryColor = Color(0xFF800000);
const Color secColor = Color(0xFFFFFFFF);
const Color backgroundColor = Color(0xFFF2F2F2);
MaterialColor primaryColorTheme = const MaterialColor(
  0xFF800000,
  <int, Color>{
    50: Color(0xFFA4A4BF),
    100: Color(0xFFA4A4BF),
    200: Color(0xFFA4A4BF),
    300: Color(0xFF9191B3),
    400: Color(0xFF7F7FA6),
    500: Color(0xFF181861),
    600: Color(0xFF9e1919),
    700: Color(0xFFb11c1c),
    800: Color(0xFFcb3535),
    900: Color(0xFFd14c4c),
  },
);
const btnBgColor = Color(0xFF800000);
const btnTxtColor = Color.fromRGBO(255, 255, 255, 1.0);

const CACHED_USER_DATA = "CACHED_USER_DATA";

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  DeliveryTime,
  AddAddress,
  Summary,
}

enum Delivery { standardDelivery, nextDayDelivery, nominatedDelivery }
