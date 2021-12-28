import 'dart:io';

import 'package:connectivity/connectivity.dart';

class CheckConnection {
  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final response = await InternetAddress.lookup('www.google.com');
        if (response.isNotEmpty) {
          return true;
        }
      } on SocketException catch (err) {
        print(err);
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final response = await InternetAddress.lookup('www.google.com');
        if (response.isNotEmpty) {
          return true;
        }
      } on SocketException catch (err) {
        print(err);
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
    return false;
  }
}
