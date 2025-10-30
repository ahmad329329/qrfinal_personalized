import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qrfinal_personalized/res/routes/routes_names.dart';
import 'package:qrfinal_personalized/utils/utils.dart';

import '../repositories/login_repository/Login_Repository.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final _api= LoginRepository();

  RxBool loading = false.obs;

  bool validateCredentials() {
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final passwordRegex = RegExp(r'^.{8,}$');

    if (email.isEmpty) {
      Utils.snackbar('Error', 'Email cannot be empty');
      return false;
    } else if (!emailRegex.hasMatch(email)) {
      Utils.snackbar('Invalid Email', 'Please enter a valid email address');
      return false;
    }

    if (password.isEmpty) {
      Utils.snackbar('Error', 'Password cannot be empty');
      return false;
    } else if (!passwordRegex.hasMatch(password)) {
      Utils.snackbar('Invalid Password', 'Password must be at least 8 characters long');
      return false;
    }

    return true;
  }
  void loginApi() async {
    if (!validateCredentials()) return;
    loading.value = true;

    Map data= {
      'email':emailController.value.text,
      'password':passwordController.value.text,
    };

    _api.loginapi(data).then((value){
      loading.value = false;
      log(value.toString());
      if(value['status'].toString() == 'true'){
        Utils.snackbar('Success', 'Login Successfully');
        Get.offNamed(RouteName.homeScreen);
      }
      else{
        Utils.snackbar('Error', 'Invalid Credentials');
      }
    }).onError((error, StackTrace){
      loading.value = false;
      Utils.snackbar('Error', error.toString());

    });
    }
  }

