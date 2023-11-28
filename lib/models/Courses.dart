import 'dart:convert';

class Courses {
  final int instanceId;
  final String title;
  final String classTime;
  final String classDay;
  final Object duration;
  final Object price;
  final String date;
  final String teacher;
  final String type;
  bool isBooked;
  bool isFav;

  Courses({
    required this.instanceId,
    required this.title,
    required this.classTime,
    required this.classDay,
    required this.duration,
    required this.price,
    required this.date,
    required this.teacher,
    required this.type,
    required this.isBooked,
    required this.isFav,
  });

  factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      instanceId: json['instanceId'],
      title: json['title'],
      classTime: json['classTime'],
      classDay: json['classDay'],
      duration: json['duration'],
      price: json['price'],
      date: json['date'],
      teacher: json['teacher'],
      type: json['type'],
      isBooked: json['isBooked'],
      isFav: json['isFav'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instanceId': instanceId,
      'title': title,
      'classTime': classTime,
      'classDay': classDay,
      'duration': duration,
      'price': price,
      'date': date,
      'teacher': teacher,
      'type': type,
      'isBooked': isBooked,
      'isFav': isFav
    };
  }
}
