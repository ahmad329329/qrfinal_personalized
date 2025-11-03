import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../controllers/attendence_stats_controller.dart';

class AttendanceStatisticsScreen extends StatelessWidget {
  const AttendanceStatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttendanceStatisticsController());

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text("Attendance Statistics"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.attendanceStats.isEmpty) {
          return const Center(
            child: Text("No attendance data available"),
          );
        }

        final subjects = controller.attendanceStats;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              // Top Grid
              Expanded(
                flex: 1,
                child: GridView.builder(
                  itemCount: subjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (context, index) {
                    final sub = subjects[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sub.subject,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "${sub.attendance}%",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: _getColor(sub.attendance)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Bar Chart
              Expanded(
                flex: 1,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: Colors.white,
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        minY: 0,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: Colors.grey.shade300,
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              getTitlesWidget: (value, meta) {
                                if (value % 20 == 0) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.black),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final index = value.toInt();
                                if (index < 0 || index >= subjects.length) {
                                  return const SizedBox.shrink();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Text(
                                    subjects[index].subject.split(' ').first,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.black87),
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: subjects.asMap().entries.map((entry) {
                          final index = entry.key;
                          final attendance = entry.value.attendance;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                toY: attendance.toDouble(),
                                color: _getColor(attendance),
                                width: 18,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  static Color _getColor(int value) {
    if (value >= 85) return Colors.green;
    if (value >= 70) return Colors.orange;
    return Colors.red;
  }
}
