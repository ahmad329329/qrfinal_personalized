


import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:qrfinal_personalized/bindings/Home_Bindings.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';
import 'package:qrfinal_personalized/views/Home_Screen/Home_Screen.dart';
import 'package:qrfinal_personalized/views/Notifcation_Screen/Notifcation_Screen.dart';
import 'package:qrfinal_personalized/views/Singup_screen/Signup_Screen.dart';
import 'package:qrfinal_personalized/views/attendence_record_screen/Attendence_Screen.dart';
import 'package:qrfinal_personalized/views/class_shedule_screen/Class_Shedule_Screen.dart';
import 'package:qrfinal_personalized/views/Login_Screen/login_screen.dart';
import 'package:qrfinal_personalized/views/Onboarding_Screen/onboarding_screen.dart';

import '../../bindings/Loign_Bindings.dart';
import '../../bindings/Signup_Bindings.dart';
import '../../views/Splash_Screen/Splash_screen.dart';
import '../../views/attendence_statatics_screen/Attendence_Statictics_Screen.dart';

class AppRoute{

  static approutes() =>[
    GetPage(name: RouteName.splashScreen, page: () => SplashScreen(),
    transition: Transition.leftToRightWithFade,
    transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.onboardingScreen, page: () => OnboardingScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.loginScreen, page: () => LoginScreen(),
        transition: Transition.leftToRightWithFade,
        binding: LoginViewBinding(),
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.signupScreen, page: () => SignupScreen(),
        transition: Transition.leftToRightWithFade,
        binding: SignupViewBindings(),
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.homeScreen, page: () => HomeScreen(),
        transition: Transition.leftToRightWithFade,
        binding: HomeViewBindings(),
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.attendencerecordScreen, page: () => AttendanceRecordScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.attendencestaticticsScreen, page: () => AttendanceStatisticsScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.notifcationScreen, page: () => NotificationScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(microseconds: 250)),

    GetPage(name: RouteName.classsheduleScreen, page: () => ClassScheduleScreen(),
        transition: Transition.leftToRightWithFade,
        transitionDuration: Duration(microseconds: 250)),
  ];

}