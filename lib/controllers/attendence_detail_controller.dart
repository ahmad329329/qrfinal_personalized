import 'package:get/get.dart';
import '../User_Prefrences/User_Prefrecnes.dart';
import '../repositories/attendence_detail_repository/AttendenceDetailRepository.dart';

class AttendanceController extends GetxController {
  final Attendencedetailrepository _api = Attendencedetailrepository();
  final UserPrefrences userPref = UserPrefrences();

  var attendanceData = <String, Map<String, List<Map<String, String>>>>{}.obs;
  var selectedMonth = "".obs;
  var selectedSubject = "All Subjects".obs;
  var isLoading = false.obs;

  void fetchAttendance() async {
    isLoading(true);

    final user = await userPref.getUser();
    if (user.id == null) {
      isLoading(false);
      return;
    }

    final Map<String, dynamic> data = {"user_id": user.id};
    print("data: $data");

    final response = await _api.getattendenceapi(data);
    print("response: $response");

    if (response['status'] == true && response['attendance'] != null) {
      final Map<String, Map<String, List<Map<String, String>>>> parsedData = {};

      // Parse safely, regardless of how PHP sends arrays
      (response['attendance'] as Map).forEach((monthKey, monthValue) {
        final Map<String, List<Map<String, String>>> monthMap = {};

        (monthValue as Map).forEach((dateKey, dateValue) {
          // Ensure it's a list of maps
          final List<Map<String, String>> lectures = (dateValue as List)
              .map((item) => Map<String, String>.from(item))
              .toList();

          monthMap[dateKey.toString()] = lectures;
        });

        parsedData[monthKey.toString()] = monthMap;
      });

      attendanceData.value = parsedData;

      // Select first month automatically
      if (attendanceData.isNotEmpty) {
        selectedMonth.value = attendanceData.keys.first;
      }

    } else {
      print("⚠️ Invalid response or no data found");
    }

    isLoading(false);
  }

  List<String> extractSubjects() {
    final subjects = <String>{};
    for (var month in attendanceData.values) {
      for (var lectures in month.values) {
        for (var lecture in lectures) {
          subjects.add(lecture["subject"] ?? "");
        }
      }
    }
    return subjects.toList();
  }
}
