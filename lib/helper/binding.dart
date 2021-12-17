import 'package:e_commerce/view_model/auth_view_model.dart';
import 'package:e_commerce/view_model/checkout_view_model.dart';
import 'package:e_commerce/view_model/control_view_model.dart';
import 'package:e_commerce/view_model/home_view_model.dart';
import 'package:e_commerce/view_model/profile_view_model.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => ControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ProfileViewModel());
    Get.lazyPut(() => CheckOutViewModel());
    //Get.lazyPut(() => CartViewModel());
    Get.lazyPut(
      () => LocalStorageData(),
    );
  }
}
