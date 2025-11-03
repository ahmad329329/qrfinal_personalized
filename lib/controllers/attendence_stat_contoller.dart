import 'package:get/get.dart';
import '../Models/attendence_statictics_model.dart';
import '../User_Prefrences/User_Prefrecnes.dart';
import '../repositories/attendence_statictics_repository/AttendenceStaticsRepository.dart';

class AttendanceStatisticsController extends GetxController {
  final Attendencestaticsrepository repository =
  Attendencestaticsrepository();
  final UserPrefrences userPrefrences = UserPrefrences();

  var attendanceStats = <AttendanceStatModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAttendanceStatistics();
  }

  void fetchAttendanceStatistics() async {
    try {
      isLoading(true);
      final user = await userPrefrences.getUser();
      if (user != null) {
        final data = await repository.getstaticticsapi(user.id.toString());
        attendanceStats.assignAll(data);
      }
    } catch (e) {
      print("❌ Error fetching statistics: $e");
    } finally {
      isLoading(false);
    }
  }
}
