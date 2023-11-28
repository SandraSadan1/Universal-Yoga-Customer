import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/models/Courses.dart';
import 'package:universal_yoga/ui/CourseCard.dart';
import 'package:universal_yoga/utils/services/ApiService.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  List<Courses> courses = [];
  bool isLoading = false;
  final ApiService apiService = ApiService();

  Future<void> saveInitCourse() async {
    setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();
    courses = await apiService.getInstances();
    prefs.setString('courses', jsonEncode(courses));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveInitCourse();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: SvgPicture.asset(
                    'assets/avatar.svg',
                    semanticsLabel: 'My SVG Image',
                    width: (width / 3) * 2,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: SvgPicture.asset(
                    'assets/circle_big.svg',
                    semanticsLabel: 'My SVG Image',
                    // width: (width / 3) * 2,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 120,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: SvgPicture.asset(
                    'assets/circle_small.svg',
                    semanticsLabel: 'My SVG Image',
                    // width: (width / 3) * 2,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  width: width / 2,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 10, top: 65),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Namaste,',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: ConstantColors.black1,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Ethan',
                          style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: ConstantColors.black1,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: height / 3.5,
                child: Column(
                  children: [
                    SizedBox(
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Let’s start basic ',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                              // textAlign: TextAlign.left,
                            ),
                            const Text(
                              'yoga and meditation',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: Colors.black,
                              ),
                              // textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Recommended Courses',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: ConstantColors.black1,
                              ),
                              // textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                            isLoading
                                ? Container()
                                : CourseCard(
                                    id: courses[0].instanceId,
                                    title: courses[0].title,
                                    time: courses[0].classTime,
                                    duration: courses[0].duration,
                                    price: courses[0].price,
                                    date: courses[0].date,
                                    teacher: courses[0].teacher,
                                    type: courses[0].type,
                                    isBooked: courses[0].isBooked,
                                    isFav: courses[0].isFav,
                                  )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
