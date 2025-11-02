class AttendanceStatModel {
  final String subject;
  final int attendance;

  AttendanceStatModel({
    required this.subject,
    required this.attendance,
  });

  factory AttendanceStatModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatModel(
      subject: json['subject'] ?? 'Unknown',
      attendance: int.tryParse(json['attendance'].toString()) ?? 0,
    );
  }
}
