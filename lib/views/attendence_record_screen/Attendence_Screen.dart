import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceRecordScreen extends StatelessWidget {
  AttendanceRecordScreen({super.key});

  // Reactive state using GetX
  final selectedMonth = "October 2025".obs;
  final selectedSubject = "All Subjects".obs;


  final Map<String, Map<String, List<Map<String, String>>>> data = {
    "October 2025": {
      "Oct 21, 2025": [
        {"subject": "Mobile App Development", "teacher": "Sir Usman Ali", "status": "Present"},
        {"subject": "Database Systems", "teacher": "Sir Ahmed Khan", "status": "Absent"},
        {"subject": "Software Testing", "teacher": "Sir Bilal", "status": "Late"},
        {"subject": "Operating Systems", "teacher": "Sir Kamran", "status": "Present"},
      ],
      "Oct 22, 2025": [
        {"subject": "Mobile App Development", "teacher": "Sir Usman Ali", "status": "Present"},
        {"subject": "AI Fundamentals", "teacher": "Miss Hina", "status": "Present"},
        {"subject": "Software Engineering", "teacher": "Sir Usman Ali", "status": "Present"},
        {"subject": "Discrete Math", "teacher": "Sir Waseem", "status": "Absent"},
      ],
    },
    "November 2025": {
      "Nov 2, 2025": [
        {"subject": "Mobile App Development", "teacher": "Sir Usman Ali", "status": "Late"},
        {"subject": "Database Systems", "teacher": "Sir Ahmed Khan", "status": "Present"},
        {"subject": "Compiler Design", "teacher": "Sir Ali", "status": "Absent"},
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
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
          final monthData = data[selectedMonth.value] ?? {};
          final allSubjects = _extractSubjects(data);
          final filteredSubject = selectedSubject.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Filters Row
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown(
                      label: "Month",
                      value: selectedMonth.value,
                      items: data.keys.toList(),
                      onChanged: (val) => selectedMonth.value = val!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildDropdown(
                      label: "Subject",
                      value: selectedSubject.value,
                      items: ["All Subjects", ...allSubjects],
                      onChanged: (val) => selectedSubject.value = val!,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔹 Month Title
              Center(
                child: Text(
                  selectedMonth.value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Attendance List
              Expanded(
                child: monthData.isEmpty
                    ? const Center(child: Text("No attendance data available"))
                    : ListView(
                  children: monthData.entries.map((entry) {
                    final date = entry.key;
                    final lectures = entry.value
                        .where((lecture) =>
                    filteredSubject == "All Subjects" ||
                        lecture["subject"] == filteredSubject)
                        .toList();

                    if (lectures.isEmpty) return const SizedBox();

                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Teacher: ${lecture["teacher"]!} | Status: $status",
                                  style: TextStyle(color: color, fontSize: 13),
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

  // 🔹 Helper Dropdown Widget
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
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // 🔹 Helper Methods
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

  String _getComment(String status) {
    switch (status) {
      case "Present":
        return "Attended the class on time and participated well.";
      case "Absent":
        return "Did not attend this lecture.";
      case "Late":
        return "Arrived late but attended most of the session.";
      default:
        return "No comment available.";
    }
  }

  List<String> _extractSubjects(Map<String, Map<String, List<Map<String, String>>>> data) {
    final subjects = <String>{};
    for (var month in data.values) {
      for (var lectures in month.values) {
        for (var lecture in lectures) {
          subjects.add(lecture["subject"]!);
        }
      }
    }
    return subjects.toList();
  }
}
