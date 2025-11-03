import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/class_shedule_controller.dart';

class ClassScheduleScreen extends StatelessWidget {
  const ClassScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassScheduleController());

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.weeklySchedule.isEmpty) {
        return const Scaffold(
          body: Center(child: Text("No class schedule available")),
        );
      }

      final days = controller.weeklySchedule.keys.toList();

      return DefaultTabController(
        length: days.length,
        child: Scaffold(
          backgroundColor: Colors.blue.shade50,
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "Class Schedule",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              tabs: days.map((day) => Tab(text: day)).toList(),
            ),
          ),
          body: TabBarView(
            children: days.map((day) {
              final classes = controller.weeklySchedule[day]!;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  final item = classes[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.subject,
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time,
                                color: Colors.grey, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              "${item.startTime} - ${item.endTime}",
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                color: Colors.grey, size: 18),
                            const SizedBox(width: 8),
                            Text(item.room,
                                style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.person,
                                color: Colors.grey, size: 18),
                            const SizedBox(width: 8),
                            Text(item.teacher,
                                style: const TextStyle(color: Colors.black54)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      );
    });
  }
}
