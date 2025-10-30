

import 'package:get/get.dart';
import 'package:qrfinal_personalized/controllers/signupController.dart';



class SignupViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(() => SignupController());

  }
}
