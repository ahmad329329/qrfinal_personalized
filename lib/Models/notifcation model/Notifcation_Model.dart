class NotificationModel {
  final String title;
  final String message;
  final String type;
  final String createdAt;

  NotificationModel({
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      type: json['type'] ?? 'info',
      createdAt: json['created_at'] ?? '',
    );
  }
}
