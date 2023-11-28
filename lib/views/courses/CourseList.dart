import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/utils/MockData.dart';

import '../../models/Courses.dart';
import '../../ui/CourseCard.dart';
import '../../utils/ConstantColors.dart';
import '../layout/MyCart.dart';

class CourseList extends StatefulWidget {
  final String title;
  late List<Courses> courses;

  CourseList({
    super.key,
    required this.title,
    required this.courses,
  });

  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  bool isLoading = false;

  int noOfCoursesInCart = 0;
  late SharedPreferences prefs;
  List<Courses> myCourses = [];
  List<Courses> myCart = [];

  void updateCartValue(int newValue) {
    if (newValue != noOfCoursesInCart) {
      setState(() {
        isLoading = true;
        myCourses = [];
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
          if (widget.title.contains('Flow') && c.type == MockData.FLOW_YOGA) {
            myCourses.add(c);
          } else if (widget.title.contains('Ariel') &&
              c.type == MockData.ARIEL_YOGA) {
            myCourses.add(c);
          } else if (widget.title.contains('Family') &&
              c.type == MockData.FAMILY_YOGA) {
            myCourses.add(c);
          }
        });
      }
      setState(() {
        widget.courses = myCourses;
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

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                widget.title,
                style: GoogleFonts.pacifico(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.courses.isNotEmpty && !isLoading
                  ? SizedBox(
                      height: displayHeight - 110,
                      width: displayWidth,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: widget.courses.length,
                        itemBuilder: (context, index) => CourseCard(
                          id: widget.courses[index].instanceId,
                          title: widget.courses[index].title,
                          time: widget.courses[index].classTime,
                          duration: widget.courses[index].duration,
                          price: widget.courses[index].price,
                          date: widget.courses[index].date,
                          teacher: widget.courses[index].teacher,
                          type: widget.courses[index].type,
                          isBooked: widget.courses[index].isBooked,
                          isFav: widget.courses[index].isFav,
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
