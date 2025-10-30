import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qrfinal_personalized/res/routes/routes.dart';
import 'package:qrfinal_personalized/views/Splash_Screen/Splash_screen.dart';

import '../res/routes/routes_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteName.splashScreen,
      getPages: AppRoute.approutes(),
      home: SplashScreen()
    );
  }
}

