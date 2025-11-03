import 'package:get/get.dart';
import '../Models/class_shedule_model/classSheduleModel.dart';
import '../repositories/classShedule_repository/ClassSheduleRepository.dart';

class ClassScheduleController extends GetxController {
  final ClassScheduleRepository _repository = ClassScheduleRepository();

  var isLoading = true.obs;
  var weeklySchedule = <String, List<ClassScheduleModel>>{}.obs;

  @override
  void onInit() {
    fetchClassSchedule();
    super.onInit();
  }

  Future<void> fetchClassSchedule() async {
    try {
      isLoading(true);
      final allClasses = await _repository.fetchSchedule();

      final Map<String, List<ClassScheduleModel>> grouped = {};
      for (var cls in allClasses) {
        grouped.putIfAbsent(cls.day, () => []);
        grouped[cls.day]!.add(cls);
      }

      weeklySchedule.assignAll(grouped);
    } catch (e) {
      print("❌ Error fetching class schedule: $e");
    } finally {
      isLoading(false);
    }
  }
}
