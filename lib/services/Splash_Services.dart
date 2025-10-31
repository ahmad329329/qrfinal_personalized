import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';
import '../User_Prefrences/User_Prefrecnes.dart';


class SplashServices{

  UserPrefrences userPrefrences=UserPrefrences();

  islogin(){
    userPrefrences.getUser().then((value){
   log(value!.id.toString());
      if(value.id==null){
        Timer(
            Duration(seconds: 3),
                ()=>
                Get.offAllNamed(RouteName.onboardingScreen));
      }else{
        Timer(
        Duration(seconds: 3),
        ()=>
        Get.offAllNamed(RouteName.homeScreen));
        }
    }
    );
  }
}
