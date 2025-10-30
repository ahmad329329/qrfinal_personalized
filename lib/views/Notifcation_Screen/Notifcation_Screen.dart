import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // Example notifications (can later be fetched from API)
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "Attendance Marked",
      "message": "You were marked Present in Mobile App Development.",
      "time": "2 hours ago",
      "type": "success"
    },
    {
      "title": "New Announcement",
      "message": "Midterm exams will start from November 10th.",
      "time": "5 hours ago",
      "type": "info"
    },
    {
      "title": "Attendance Alert",
      "message": "You were marked Absent in Database Systems.",
      "time": "Yesterday",
      "type": "warning"
    },
    {
      "title": "Lecture Cancelled",
      "message": "Today’s Software Testing class is cancelled.",
      "time": "2 days ago",
      "type": "cancel"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Notifications"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final color = _getColor(notification["type"]);
            final icon = _getIcon(notification["type"]);

            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 2,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: color.withOpacity(0.2),
                  child: Icon(icon, color: color),
                ),
                title: Text(
                  notification["title"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      notification["message"],
                      style: const TextStyle(color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification["time"],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "success":
        return Icons.check_circle;
      case "info":
        return Icons.info;
      case "warning":
        return Icons.warning_amber_rounded;
      case "cancel":
        return Icons.cancel;
      default:
        return Icons.notifications;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case "success":
        return Colors.green;
      case "info":
        return Colors.blue;
      case "warning":
        return Colors.orange;
      case "cancel":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
