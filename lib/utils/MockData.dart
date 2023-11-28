import 'package:universal_yoga/models/Courses.dart';

class MockData {
  static const FLOW_YOGA = 'FLOW_YOGA';
  static const ARIEL_YOGA = 'ARIEL_YOGA';
  static const FAMILY_YOGA = 'FAMILY_YOGA';
  List<Courses> flowYoga = [
    Courses(
      instanceId: 1,
      title: 'Yoga Pilates',
      classTime: '08:00 AM',
      classDay: 'Tuesday',
      duration: "2",
      price: 20,
      date: '20/11/2023',
      teacher: 'Sarah William',
      type: FLOW_YOGA,
      isBooked: false,
      isFav: false,
    ),
    Courses(
      instanceId: 2,
      title: 'Yoga Pilates',
      classTime: '08:00 AM',
      classDay: 'Tuesday',
      duration: "2",
      price: 20,
      date: '20/11/2023',
      teacher: 'Sarah William',
      type: ARIEL_YOGA,
      isBooked: false,
      isFav: false,
    ),
    Courses(
      instanceId: 3,
      title: 'Yoga Pilates',
      classTime: '08:00 AM',
      classDay: 'Tuesday',
      duration: "2",
      price: 20,
      date: '20/11/2023',
      teacher: 'Sarah William',
      type: FAMILY_YOGA,
      isBooked: false,
      isFav: false,
    ),
  ];
}
