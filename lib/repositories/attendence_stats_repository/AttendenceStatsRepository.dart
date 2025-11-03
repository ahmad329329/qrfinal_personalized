import 'package:qrfinal_personalized/res/ap_url/app_url.dart';
import '../../Models/attendence model/Notifcation_Model.dart';
import '../../data/network/Network_Api_Services.dart';

class Attendencestaticsrepository {
  final _apiServices = NetworkApiServices();

  Future<List<AttendanceStatModel>> getstaticticsapi(var data) async {
    final response = await _apiServices.postapi(data, AppUrl.getattendenceApi);

    if (response["status"] == true && response["attendance"] != null) {
      final Map<String, dynamic> attendance = response["attendance"];
      final Map<String, int> totalClasses = {};
      final Map<String, int> presentClasses = {};

      attendance.forEach((month, monthData) {
        (monthData as Map<String, dynamic>).forEach((date, lectures) {
          (lectures as List).forEach((lecture) {
            final subject = lecture["subject"] ?? "Unknown";
            totalClasses[subject] = (totalClasses[subject] ?? 0) + 1;

            if ((lecture["status"] ?? "").toLowerCase() == "present") {
              presentClasses[subject] = (presentClasses[subject] ?? 0) + 1;
            }
          });
        });
      });

      final List<AttendanceStatModel> stats = [];
      totalClasses.forEach((subject, total) {
        final present = presentClasses[subject] ?? 0;
        final percentage = ((present / total) * 100).round();
        stats.add(AttendanceStatModel(subject: subject, attendance: percentage));
      });

      return stats;
    } else {
      return [];
    }
  }
}
