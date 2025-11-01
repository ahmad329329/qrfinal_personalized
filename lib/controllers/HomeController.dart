import 'package:get/get.dart';
import 'package:qrfinal_personalized/repositories/home_repository/HomeRepository.dart';
import '../User_Prefrences/User_Prefrecnes.dart';

class HomeController extends GetxController {
  final UserPrefrences userPrefrences = UserPrefrences();
  final HomeRepository _api = HomeRepository();

  var name = ''.obs;
  var role = ''.obs;
  var degree = ''.obs;
  var registrationNo = ''.obs;

  @override
  void onInit() {
    super.onInit();
    homeData();
  }

  void homeData() {
    userPrefrences.getUser().then((user) {
      if (user != null) {
        final Map<String, dynamic> data = {"user_id": user.id};

        _api.homeapi(data).then((response) {
          if (response['status'] == true) {
            name.value = response['user']['name'];
            role.value = response['user']['role'];
            degree.value = response['user']['degree'];
            registrationNo.value = response['user']['reg_no'];
          }
        });
      }
    });
  }
}
