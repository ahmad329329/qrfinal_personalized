import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Models/notifcation model/Notifcation_Model.dart';
import '../../res/ap_url/app_url.dart';

class NotificationRepository {
  Future<List<NotificationModel>> getNotifications() async {
    final response = await http.get(Uri.parse(AppUrl.getnotication));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      if (jsonData['status'] == true && jsonData['notifications'] != null) {
        final List list = jsonData['notifications'];
        return list.map((e) => NotificationModel.fromJson(e)).toList();
      }
      return [];
    } else {
      throw Exception("Failed to fetch notifications");
    }
  }
}
