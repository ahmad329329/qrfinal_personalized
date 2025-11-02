import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrfinal_personalized/User_Prefrences/User_Prefrecnes.dart';
import '../../controllers/attendence_detail_controller.dart';

class AttendanceRecordScreen extends StatelessWidget {
  AttendanceRecordScreen({super.key});

  final AttendanceController controller = Get.put(AttendanceController());
  final UserPrefrences userPrefrences = UserPrefrences();

  @override
  Widget build(BuildContext context) {
    // ✅ Fetch user data from preferences once the widget builds
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await userPrefrences.getUser();
      if (user.id != null && user.id!.isNotEmpty) {
        controller.fetchAttendance();
      } else {
        Get.snackbar("Error", "User not found in preferences");
      }
    });

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Monthly Attendance"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = controller.attendanceData;
          if (data.isEmpty) {
            return const Center(child: Text("No attendance data available"));
          }

          final monthData = data[controller.selectedMonth.value] ?? {};
          final allSubjects = controller.extractSubjects();
          final filteredSubject = controller.selectedSubject.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Filters
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: "Month",
                      value: controller.selectedMonth.value,
                      items: data.keys.toList(),
                      onChanged: (val) => controller.selectedMonth.value = val!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      label: "Subject",
                      value: controller.selectedSubject.value,
                      items: ["All Subjects", ...allSubjects],
                      onChanged: (val) => controller.selectedSubject.value = val!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: Text(
                  controller.selectedMonth.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: monthData.entries.map((entry) {
                    final date = entry.key;
                    final lectures = entry.value
                        .where((lecture) =>
                    filteredSubject == "All Subjects" ||
                        lecture["subject"] == filteredSubject)
                        .toList();

                    if (lectures.isEmpty) return const SizedBox();

                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            const Divider(),
                            ...lectures.map((lecture) {
                              final status = lecture["status"]!;
                              final color = _getStatusColor(status);
                              final icon = _getStatusIcon(status);

                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(icon, color: color, size: 30),
                                title: Text(
                                  lecture["subject"]!,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Teacher: ${lecture["teacher"]!} | Status: $status",
                                  style:
                                  TextStyle(color: color, fontSize: 13),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          items: items
              .map((item) =>
              DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case "Present":
        return Icons.check_circle;
      case "Absent":
        return Icons.cancel;
      case "Late":
        return Icons.access_time;
      default:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Present":
        return Colors.green;
      case "Absent":
        return Colors.red;
      case "Late":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
