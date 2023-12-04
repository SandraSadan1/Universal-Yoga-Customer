import 'dart:convert';

class Courses {
  final int instanceId; //
  final String classTime; //
  final String classDay; //
  final String date; //
  final String teacher; //
  bool isBooked;

  Courses({
    required this.instanceId,
    required this.classTime,
    required this.classDay,
    required this.date,
    required this.teacher,
    required this.isBooked,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      instanceId: json['instanceId'],
      classTime: json['classTime'],
      classDay: json['classDay'],
      date: json['date'],
      teacher: json['teacher'],
      isBooked: json['isBooked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instanceId': instanceId,
      'classTime': classTime,
      'classDay': classDay,
      'date': date,
      'teacher': teacher,
      'isBooked': isBooked,
    };
  }
}
