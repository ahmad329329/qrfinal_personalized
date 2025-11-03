import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/class_shedule_model/classSheduleModel.dart';

class ClassScheduleRepository {
  final String baseUrl = "http://192.168.0.217/api"; // 🔹 Change to your IP

  Future<List<ClassScheduleModel>> fetchSchedule() async {
    final response = await http.get(Uri.parse("$baseUrl/get_classes.php"));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData["status"] == true) {
        return (jsonData["data"] as List)
            .map((e) => ClassScheduleModel.fromJson(e))
            .toList();
      } else {
        throw Exception("No schedule found");
      }
    } else {
      throw Exception("Failed to load schedule");
    }
  }
}
