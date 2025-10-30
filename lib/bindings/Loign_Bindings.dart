

import 'package:get/get.dart';
import 'package:qrfinal_personalized/controllers/loginController.dart';


class LoginViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
