
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qrfinal_personalized/User_Prefrences/User_Prefrecnes.dart';
import 'package:qrfinal_personalized/repositories/signup_repository/Signup_Repository.dart';
import '../../utils/utils.dart';
import '../Models/User_model/User_Model.dart';
import '../res/routes/routes_names.dart';

class SignupController extends GetxController {
  UserPrefrences userPrefrences=UserPrefrences();

  final _api= SignupRepository();

  // ✅ Controllers
  final nameController = TextEditingController().obs;
  final regNoController = TextEditingController().obs;
  final degreeController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  // ✅ Focus Nodes
  final nameFocusNode = FocusNode().obs;
  final regNoFocusNode = FocusNode().obs;
  final degreeFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;

  RxBool loading = false.obs;

  // ✅ Input Validation
  bool validateCredentials() {
    String name = nameController.value.text.trim();
    String regNo = regNoController.value.text.trim();
    String degree = degreeController.value.text.trim();
    String email = emailController.value.text.trim();
    String password = passwordController.value.text.trim();

    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    final passwordRegex = RegExp(r'^.{8,}$');

    if (name.isEmpty) {
      Utils.snackbar('Error', 'Name cannot be empty');
      return false;
    }

    if (regNo.isEmpty) {
      Utils.snackbar('Error', 'Registration Number cannot be empty');
      return false;
    }

    if (degree.isEmpty) {
      Utils.snackbar('Error', 'Degree cannot be empty');
      return false;
    }

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

  // ✅ Signup APi
void signupApi() async {
  if (!validateCredentials()) return;
  loading.value = true;

  Map data= {
    'email':emailController.value.text,
    'password':passwordController.value.text,
    'name':nameController.value.text,
    'reg_no':regNoController.value.text,
    'degree':degreeController.value.text,
  };

  _api.Signupapi(data).then((value) {
    loading.value = false;
    print(value.toString());
    if (value['status'].toString() == 'true') {
      Utils.snackbar('Success', 'Registration Successfully');
      userPrefrences.saveUser(UserModel(value['id'].toString()));
      Get.offNamed(RouteName.homeScreen);
    }
    if (value['status'].toString() == 'false') {
      Utils.snackbar('Error', value['message']);
    } else {
      Utils.snackbar('Error', 'Registration Failed');
    }
  }
  ).onError((error, StackTrace){
    loading.value = false;
    Utils.snackbar('Error', error.toString());

  });
}
}
