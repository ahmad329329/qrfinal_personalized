import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';


class SplashServices{
  islogin(){
    Timer(
        Duration(seconds: 3),
            ()=>
            Get.offAllNamed(RouteName.onboardingScreen)
    );
  }
}
