import 'package:get/get.dart';
import '../Models/attendence model/Notifcation_Model.dart';
import '../User_Prefrences/User_Prefrecnes.dart';
import '../repositories/attendence_stats_repository/AttendenceStatsRepository.dart';

class AttendanceStatisticsController extends GetxController {
  final Attendencestaticsrepository _repo = Attendencestaticsrepository();
  final UserPrefrences _userPref = UserPrefrences();

  var attendanceStats = <AttendanceStatModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistics();
  }

  void fetchStatistics() async {
    isLoading(true);

    final user = await _userPref.getUser();
    if (user.id == null) {
      isLoading(false);
      return;
    }

    final data = {"user_id": user.id};
    try {
      final stats = await _repo.getstaticticsapi(data);
      attendanceStats.value = stats;

      // Debug logs
      print("API returned ${stats.length} items");
      for (var stat in stats) {
        print('Subject: ${stat.subject}, Attendance: ${stat.attendance}%');
      }

    } catch (e) {
      print("Error fetching statistics: $e");
    }

    isLoading(false);
  }
}
