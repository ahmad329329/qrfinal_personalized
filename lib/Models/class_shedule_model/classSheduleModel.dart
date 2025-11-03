class ClassScheduleModel {
  final String subject;
  final String teacher;
  final String room;
  final String day;
  final String startTime;
  final String endTime;

  ClassScheduleModel({
    required this.subject,
    required this.teacher,
    required this.room,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory ClassScheduleModel.fromJson(Map<String, dynamic> json) {
    return ClassScheduleModel(
      subject: json['subject'] ?? '',
      teacher: json['teacher_name'] ?? '',
      room: json['room'] ?? '',
      day: json['day'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }
}
