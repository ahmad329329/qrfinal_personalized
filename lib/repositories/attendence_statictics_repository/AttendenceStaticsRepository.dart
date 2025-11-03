import 'package:qrfinal_personalized/res/ap_url/app_url.dart';
import '../../Models/attendence_statictics_model.dart';
import '../../data/network/Network_Api_Services.dart';

class Attendencestaticsrepository {
  final _apiServices = NetworkApiServices();

  Future<List<AttendanceStatModel>> getstaticticsapi(var data) async {
    try {
      final response = await _apiServices.postapi(data, AppUrl.getattendenceApi);

      // ✅ Expecting response like:
      // { "status": true, "data": [ { "subject": "DB", "attendance": 85 } ] }

      if (response["status"] == true && response["data"] != null) {
        final List<dynamic> list = response["data"];
        return list
            .map((item) => AttendanceStatModel.fromJson(item))
            .toList();
      } else {
        throw Exception("No attendance data found");
      }
    } catch (e) {
      rethrow;
    }
  }
}
