import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/utils/MockData.dart';
import '../../models/Courses.dart';
import '../../utils/helpers/Helpers.dart';

class CourseCategories extends StatefulWidget {
  const CourseCategories({super.key});

  @override
  State<CourseCategories> createState() => _CourseCategoriesState();
}

class _CourseCategoriesState extends State<CourseCategories> {
  late SharedPreferences prefs;

  List<Courses> courses = [];

  List<Courses> flowYogaCourses = [];
  List<Courses> arielYogaCourses = [];
  List<Courses> familyYogaCourses = [];
  List<Courses> myCart = [];

  bool isLoading = false;

  fetchCourses() async {
    setState(() {
      isLoading = true;
    });
    prefs = await SharedPreferences.getInstance();
    String? stringCourse = prefs.getString('courses');
    String? cartCourses = prefs.getString('myCart');

    if (stringCourse != null) {
      List coursesList = jsonDecode(stringCourse);
      for (var course in coursesList) {
        setState(() {
          courses.add(Courses.fromJson(course));
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
      }

      if (courses.isNotEmpty) {
        for (var course in courses) {
          setState(() {
            switch (course.type) {
              case MockData.FLOW_YOGA:
                flowYogaCourses.add(course);
                break;
              case MockData.FAMILY_YOGA:
                familyYogaCourses.add(course);
                break;
              default:
                arielYogaCourses.add(course);
                break;
            }
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: displayWidth,
            height: displayHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                  child: Text(
                    'Course Categories',
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                  ),
                ),
                !isLoading
                    ? Helpers().categoryTile(
                        context,
                        'Flow Yoga',
                        displayWidth,
                        displayHeight,
                        'assets/flow_yoga.svg',
                        Colors.green.shade100,
                        true,
                        flowYogaCourses,
                      )
                    : Container(),
                !isLoading
                    ? Helpers().categoryTile(
                        context,
                        'Ariel Yoga',
                        displayWidth,
                        displayHeight,
                        'assets/ariel_yoga.svg',
                        Colors.purple.shade100,
                        false,
                        arielYogaCourses,
                      )
                    : Container(),
                !isLoading
                    ? Helpers().categoryTile(
                        context,
                        'Family Yoga',
                        displayWidth,
                        displayHeight,
                        'assets/family_yoga.svg',
                        Colors.blue.shade100,
                        true,
                        familyYogaCourses,
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
