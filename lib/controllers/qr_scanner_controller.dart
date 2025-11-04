import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qrfinal_personalized/User_Prefrences/User_Prefrecnes.dart';
import 'package:qrfinal_personalized/repositories/Qr_repository/Qr_Repository.dart';

import '../utils/utils.dart';

class QrController extends GetxController {
  var isLoading = false.obs;
  UserPrefrences userPrefrences = UserPrefrences();

  Future<void> markAttendance(
    String qrCode,
    String studentId,
    String studentName,
  ) async {
    isLoading.value = true;
    final _api = QrRepository();
    var user = userPrefrences.getUser();
    Map data = {'user_id': user};

    _api
        .qrapi(data)
        .then((value) {
          isLoading.value = false;
        })
        .onError(
          (error, stackTrace) => Utils.snackbar('Error', error.toString()),
        );
  }
}
