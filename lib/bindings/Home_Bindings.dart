

import 'package:get/get.dart';
import 'package:qrfinal_personalized/controllers/HomeController.dart';


class HomeViewBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
