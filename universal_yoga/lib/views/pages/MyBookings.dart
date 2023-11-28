import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/views/layout/MyCart.dart';

import '../../models/Courses.dart';
import '../../ui/CourseCard.dart';

class MyBookings extends StatefulWidget {
  const MyBookings({super.key});

  @override
  State<MyBookings> createState() => _MyBookingsState();
}

class _MyBookingsState extends State<MyBookings> {
  late SharedPreferences prefs;
  List<Courses> myCourses = [];
  List<Courses> myCart = [];

  int noOfCoursesInCart = 0;
  bool isLoading = false;

  void updateCartValue(int newValue) {
    if (noOfCoursesInCart != newValue) {
      setState(() {
        isLoading = true;
        myCourses = [];
        myCart = [];
        noOfCoursesInCart = newValue;
        fetchMyCourses();
        isLoading = false;
      });
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
          if (c.isBooked) {
            myCourses.add(c);
          }
        });
      }
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

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Text(
                  'My Bookings',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              myCourses.isNotEmpty && !isLoading
                  ? SizedBox(
                      height: displayHeight - 205,
                      width: displayWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: myCourses.length,
                        itemBuilder: (context, index) => CourseCard(
                          id: myCourses[index].instanceId,
                          title: myCourses[index].title,
                          time: myCourses[index].classTime,
                          duration: myCourses[index].duration,
                          price: myCourses[index].price,
                          date: myCourses[index].date,
                          teacher: myCourses[index].teacher,
                          type: myCourses[index].type,
                          isBooked: myCourses[index].isBooked,
                          isFav: myCourses[index].isFav,
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
                        child: MyCart(updateCartValue: updateCartValue),
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
