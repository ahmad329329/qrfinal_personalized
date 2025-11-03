import 'package:get/get.dart';
import '../Models/notifcation model/Notifcation_Model.dart';
import '../repositories/notication_repository/NoticationRepository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = NotificationRepository();

  var notifications = <NotificationModel>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() async {
    try {
      isLoading(true);
      final data = await _repository.getNotifications();
      notifications.value = data;
    } catch (e) {
      notifications.clear();
      print("Error fetching notifications: $e");
    } finally {
      isLoading(false);
    }
  }
}
