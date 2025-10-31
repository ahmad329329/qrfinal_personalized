import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrfinal_personalized/User_Prefrences/User_Prefrecnes.dart';
import 'package:qrfinal_personalized/services/Splash_Services.dart';
import '../../res/assets/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();


  @override
  void initState(){
    super.initState();
    splashServices.islogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

        body: Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               // Logo
               Image.asset(
                 ImageAssets.splashscreen,
                 height: 150,
               ),
             ],
           )),
        );
  }

}
