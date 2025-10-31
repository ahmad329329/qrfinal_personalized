import 'package:flutter/material.dart';
class ClassScheduleScreen extends StatelessWidget {
  const ClassScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Day-wise lecture data
    final Map<String, List<Map<String, String>>> weeklySchedule = {
      'Monday': [
        {
          'subject': 'Mobile App Development',
          'time': '09:00 AM - 10:00 AM',
          'room': 'Lab 3',
          'teacher': 'Sir Ali Khan'
        },
        {
          'subject': 'Database Systems',
          'time': '11:00 AM - 12:00 PM',
          'room': 'Room 210',
          'teacher': 'Miss Hina'
        },
      ],
      'Tuesday': [
        {
          'subject': 'Software Testing',
          'time': '10:15 AM - 11:15 AM',
          'room': 'Room 108',
          'teacher': 'Sir Usman Ali'
        },
      ],
      'Wednesday': [
        {
          'subject': 'Operating Systems',
          'time': '09:00 AM - 10:00 AM',
          'room': 'Room 112',
          'teacher': 'Sir Abdullah'
        },
        {
          'subject': 'AI Fundamentals',
          'time': '11:30 AM - 12:30 PM',
          'room': 'Room 107',
          'teacher': 'Dr. Ayesha'
        },
      ],
      'Thursday': [
        {
          'subject': 'Discrete Math',
          'time': '10:15 AM - 11:15 AM',
          'room': 'Room 101',
          'teacher': 'Sir Kamran'
        },
        {
          'subject': 'Software Testing (Lab)',
          'time': '01:00 PM - 03:00 PM',
          'room': 'Lab 2',
          'teacher': 'Sir Usman Ali'
        },
      ],
      'Friday': [
        {
          'subject': 'Database Systems (Lab)',
          'time': '09:00 AM - 11:00 AM',
          'room': 'Lab 1',
          'teacher': 'Miss Hina'
        },
      ],
      'Saturday': [
        {
          'subject': 'AI Seminar',
          'time': '10:00 AM - 11:30 AM',
          'room': 'Auditorium',
          'teacher': 'Dr. Ayesha'
        },
      ],
    };

    return DefaultTabController(
      length: weeklySchedule.keys.length,
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
            tabs: weeklySchedule.keys
                .map((day) => Tab(text: day))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: weeklySchedule.keys.map((day) {
            final classes = weeklySchedule[day]!;
            if (classes.isEmpty) {
              return const Center(
                child: Text("No classes scheduled today."),
              );
            }
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
                        item['subject']!,
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
                          Text(item['time']!,
                              style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 8),
                          Text(item['room']!,
                              style: const TextStyle(color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              color: Colors.grey, size: 18),
                          const SizedBox(width: 8),
                          Text(item['teacher']!,
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
  }
}
