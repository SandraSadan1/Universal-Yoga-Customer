import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/models/Bookings.dart';
import 'package:universal_yoga/models/Payload.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/utils/Constants.dart';

import '../models/Courses.dart';
import '../utils/helpers/Helpers.dart';
import '../utils/services/ApiService.dart';

class CourseCard extends StatefulWidget {
  final int id;
  final String time;
  final String classDay;
  final String date;
  final String teacher;
  late bool isBooked;
  Function(int)? updateCartValue;

  CourseCard({
    super.key,
    required this.id,
    required this.time,
    required this.classDay,
    required this.date,
    required this.teacher,
    required this.isBooked,
    this.updateCartValue,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  ApiService apiService = ApiService();

  late SharedPreferences prefs;
  List<Courses> courses = [];
  List<Courses> cartCourses = [];

  bool isAddedToCart = false;

  fetchCourses() async {
    setState(() {
      isAddedToCart = false;
    });
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
      widget.isBooked = true;
      int index = courses.indexWhere((element) => element.instanceId == id);
      if (index > -1) {
        courses[index].isBooked = true;

        prefs.setString('courses', jsonEncode(courses));
        removeCourseFromCart(id);

        List<Bookings> bookings = List.of([Bookings(instanceId: id)]);
        Payload payload = Payload(
          userId: CONSTANTS().userId,
          b2: "Submit",
          bookingList: bookings,
        );

        apiService.bookCourse(payload).whenComplete(() =>
            Fluttertoast.showToast(
                msg: "Course booked successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0));
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
        if (widget.updateCartValue != null) {
          widget.updateCartValue!(cartCourses.length);
        }
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
        if (widget.updateCartValue != null) {
          widget.updateCartValue!(cartCourses.length);
        }
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
              Container(
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
              widget.isBooked
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Text(
                              'Booked',
                              style: GoogleFonts.inter(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.normal,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              bookCourse(widget.id);
                            },
                            child: const Text('Book'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          isAddedToCart
                              ? InkWell(
                                  onTap: () {
                                    removeCourseFromCart(widget.id);
                                  },
                                  child: Text(
                                    'Remove',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.red.withOpacity(.8),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    addCourseToCart(widget.id);
                                  },
                                  child: Text(
                                    'Add To Cart',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: ConstantColors.secondaryButtonDark
                                          .withOpacity(.8),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
