import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Courses.dart';
import '../../ui/CourseCard.dart';
import '../../utils/ConstantColors.dart';
import '../layout/MyCart.dart';

class CourseList extends StatefulWidget {
  CourseList({
    super.key,
  });

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  bool isLoading = false;

  bool isMondayChecked = false;
  bool isTuesdayChecked = false;
  bool isWednesdayChecked = false;
  bool isThursdayChecked = false;
  bool isFridayChecked = false;
  bool isSaturdayChecked = false;
  bool isSundayChecked = false;

  int noOfCoursesInCart = 0;
  late SharedPreferences prefs;
  List<Courses> myCourses = [];
  List<Courses> displayCourses = [];
  List<Courses> myCart = [];
  RangeValues _currentRangeValues = const RangeValues(00, 24);

  void updateCartValue(int newValue) {
    if (newValue != noOfCoursesInCart) {
      setState(() {
        isLoading = true;
        myCourses = [];
        displayCourses = [];
        myCart = [];
      });
      Timer(const Duration(milliseconds: 50), () => fetchMyCourses());
    }
  }

  fetchMyCourses() async {
    prefs = await SharedPreferences.getInstance();
    String? stringCourse = prefs.getString('courses');
    String? cartCourses = prefs.getString('myCart');

    if (stringCourse != null) {
      List coursesList = jsonDecode(stringCourse);
      for (var course in coursesList) {
        setState(() {
          Courses c = Courses.fromJson(course);
          myCourses.add(c);
        });
      }
      setState(() {
        displayCourses = myCourses;
        isLoading = false;
      });
    }

    if (cartCourses != null) {
      List coursesList = jsonDecode(cartCourses);
      for (var course in coursesList) {
        setState(() {
          Courses c = Courses.fromJson(course);
          myCart.add(c);
        });
      }
      setState(() {
        noOfCoursesInCart = myCart.length;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyCourses();
  }

  Future<void> _dialogBuilder(BuildContext context) {
    bool isMonday = isMondayChecked;
    bool isTuesday = isTuesdayChecked;
    bool isWednesday = isWednesdayChecked;
    bool isThursday = isThursdayChecked;
    bool isFriday = isFridayChecked;
    bool isSaturday = isSaturdayChecked;
    bool isSunday = isSundayChecked;
    StateSetter _setState;
    RangeValues _range = _currentRangeValues;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter By'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              _setState = setState;
              return SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Day',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isMonday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isMonday = value!;
                            });
                          },
                        ),
                        const Text("Monday"),
                        Checkbox(
                          value: isTuesday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isTuesday = value!;
                            });
                          },
                        ),
                        const Text("Tuesday")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isWednesday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isWednesday = value!;
                            });
                          },
                        ),
                        const Text("Wednesday"),
                        Checkbox(
                          value: isThursday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isThursday = value!;
                            });
                          },
                        ),
                        const Text("Thursday")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isFriday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isFriday = value!;
                            });
                          },
                        ),
                        const Text("Friday"),
                        Checkbox(
                          value: isSaturday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isSaturday = value!;
                            });
                          },
                        ),
                        const Text("Saturday")
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isSunday,
                          onChanged: (bool? value) {
                            _setState(() {
                              isSunday = value!;
                            });
                          },
                        ),
                        const Text("Sunday")
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Class Time',
                      style: TextStyle(fontSize: 18),
                    ),
                    RangeSlider(
                      values: _range,
                      max: 24,
                      divisions: 24,
                      labels: RangeLabels(
                        _range.start.round().toString(),
                        _range.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _range = values;
                        });
                      },
                    )
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Apply'),
              onPressed: () {
                setState(() {
                  isMondayChecked = isMonday;
                  isTuesdayChecked = isTuesday;
                  isWednesdayChecked = isWednesday;
                  isThursdayChecked = isThursday;
                  isFridayChecked = isFriday;
                  isSaturdayChecked = isSaturday;
                  isSundayChecked = isSunday;
                  _currentRangeValues = _range;
                  List<Courses> c = [];

                  if (isMondayChecked ||
                      isTuesdayChecked ||
                      isWednesdayChecked ||
                      isThursdayChecked ||
                      isFridayChecked ||
                      isSaturdayChecked ||
                      isSundayChecked) {
                    myCourses.forEach((element) {
                      if (isMondayChecked && element.classDay == "Monday") {
                        c.add(element);
                      }
                      if (isTuesdayChecked && element.classDay == "Tuesday") {
                        c.add(element);
                      }
                      if (isWednesdayChecked &&
                          element.classDay == "Wednesday") {
                        c.add(element);
                      }
                      if (isThursdayChecked && element.classDay == "Thursday") {
                        c.add(element);
                      }
                      if (isFridayChecked && element.classDay == "Friday") {
                        c.add(element);
                      }
                      if (isSaturdayChecked && element.classDay == "Saturday") {
                        c.add(element);
                      }
                      if (isSundayChecked && element.classDay == "Sunday") {
                        c.add(element);
                      }
                    });
                  } else {
                    c = myCourses;
                  }

                  List<Courses> d = [];

                  c.forEach((element) {
                    if (int.parse(element.classTime.split(":")[0]) >=
                            _range.start &&
                        int.parse(element.classTime.split(":")[0]) <=
                            _range.end) {
                      d.add(element);
                    }
                  });

                  displayCourses = d;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SizedBox(
            width: displayWidth,
            height: displayHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                      child: Text(
                        'Courses',
                        style: TextStyle(
                            fontSize: 28.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.filter_list_outlined),
                      onPressed: () => _dialogBuilder(context),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                displayCourses.isNotEmpty && !isLoading
                    ? SizedBox(
                        height: displayHeight - 205,
                        width: displayWidth,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: displayCourses.length,
                          itemBuilder: (context, index) => CourseCard(
                            id: displayCourses[index].instanceId,
                            time: displayCourses[index].classTime,
                            classDay: displayCourses[index].classDay,
                            date: displayCourses[index].date,
                            teacher: displayCourses[index].teacher,
                            isBooked: displayCourses[index].isBooked,
                            updateCartValue: updateCartValue,
                          ),
                        ),
                      )
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: displayHeight / 4),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                size: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                isLoading ? 'Loading' : 'No Courses Found',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          child: FittedBox(
            child: Stack(
              alignment: const Alignment(1.1, -1.2),
              children: [
                FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: MyCart(
                          updateCartValue: updateCartValue,
                        ),
                        type: PageTransitionType.rightToLeftWithFade,
                      ),
                    );
                  },
                  child: const Icon(Icons.shopping_cart_rounded),
                ),
                noOfCoursesInCart > 0
                    ? Container(
                        constraints:
                            const BoxConstraints(minHeight: 24, minWidth: 24),
                        decoration: BoxDecoration(
                          // This controls the shadow
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 5,
                                color: ConstantColors.appBg.withAlpha(50))
                          ],
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red.shade400,
                        ),
                        // This is your Badge
                        child: Center(
                          // Here you can put whatever content you want inside your Badge
                          child: Text(noOfCoursesInCart.toString(),
                              style: const TextStyle(color: Colors.white)),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
