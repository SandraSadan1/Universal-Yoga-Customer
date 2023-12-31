import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';

import '../models/Courses.dart';

class CartCard extends StatefulWidget {
  final int id;
  final String time;
  final String classDay;
  final String date;
  final String teacher;
  late bool isBooked;
  Function? updateCart;

  CartCard({
    super.key,
    required this.id,
    required this.time,
    required this.classDay,
    required this.date,
    required this.teacher,
    required this.isBooked,
    this.updateCart,
  });

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  late SharedPreferences prefs;
  List<Courses> courses = [];
  List<Courses> cartCourses = [];

  bool isAddedToCart = false;

  fetchCourses() async {
    prefs = await SharedPreferences.getInstance();
    String? stringCourse = prefs.getString('courses');
    String? cartCourse = prefs.getString('myCart');

    if (stringCourse != null) {
      List coursesList = jsonDecode(stringCourse);
      for (var course in coursesList) {
        setState(() {
          courses.add(Courses.fromJson(course));
        });
      }
    }

    if (cartCourse != null) {
      List coursesList = jsonDecode(cartCourse);
      for (var course in coursesList) {
        setState(() {
          Courses c = Courses.fromJson(course);
          if (c.instanceId == widget.id) {
            isAddedToCart = true;
          }
          cartCourses.add(c);
        });
      }
    }
  }

  bookCourse(int id) {
    setState(() {
      removeCourseFromCart(id);
      widget.isBooked = true;
      int index = courses.indexWhere((element) => element.instanceId == id);
      if (index > -1) {
        courses[index].isBooked = true;

        prefs.setString('courses', jsonEncode(courses));
      }
    });
  }

  addCourseToCart(int id) {
    setState(() {
      isAddedToCart = true;
      int index = courses.indexWhere((element) => element.instanceId == id);
      if (index > -1) {
        cartCourses.add(courses[index]);

        List items = cartCourses.map((e) => e.toJson()).toList();
        prefs.setString('myCart', jsonEncode(items));
        widget.updateCart!();
      }
    });
  }

  removeCourseFromCart(int id) {
    setState(() {
      isAddedToCart = false;
      int index = cartCourses.indexWhere((element) => element.instanceId == id);
      if (index > -1) {
        cartCourses.removeAt(index);

        List items = cartCourses.map((e) => e.toJson()).toList();
        prefs.setString('myCart', jsonEncode(items));
        widget.updateCart!();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 2,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: width,
          height: 110,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  color: ConstantColors.courseLogoBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                ),
                child: SvgPicture.asset('assets/course_icon.svg'),
              ),
              Expanded(
                child: Container(
                  // color: Colors.red,
                  // width: width /2,
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.classDay,
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: ConstantColors.courseTeacher,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.calendar_month_rounded,
                              size: 11,
                              color: ConstantColors.lightGrey,
                            ),
                          ),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: ConstantColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Icon(
                              Icons.access_time_rounded,
                              size: 11,
                              color: ConstantColors.lightGrey,
                            ),
                          ),
                          Text(
                            widget.time,
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              color: ConstantColors.lightGrey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Price: 10 Pound',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          color: ConstantColors.lightGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              widget.isBooked
                  ? Expanded(child: Container())
                  : ElevatedButton(
                      onPressed: () {
                        removeCourseFromCart(widget.id);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          textStyle: const TextStyle(color: Colors.white)),
                      child: const Text(
                        'Remove',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
