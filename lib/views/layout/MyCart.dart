import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_yoga/ui/CartCard.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/utils/Constants.dart';
import 'package:universal_yoga/utils/services/ApiService.dart';
import '../../models/Bookings.dart';
import '../../models/Courses.dart';
import '../../models/Payload.dart';

class MyCart extends StatefulWidget {
  final Function(int) updateCartValue;

  const MyCart({super.key, required this.updateCartValue});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  ApiService apiService = ApiService();

  late SharedPreferences prefs;
  List<Courses> myCart = [];
  List<Courses> courses = [];

  bool isLoading = false;

  int noOfCoursesInCart = 0;

  void updateCart() {
    setState(() {
      myCart = [];
      fetchMyCart();
    });
  }

  fetchMyCart() async {
    prefs = await SharedPreferences.getInstance();
    String? cartCourses = prefs.getString('myCart');
    String? stringCourse = prefs.getString('courses');

    if (stringCourse != null) {
      List coursesList = jsonDecode(stringCourse);
      for (var course in coursesList) {
        setState(() {
          courses.add(Courses.fromJson(course));
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
        widget.updateCartValue(myCart.length);
      });
    }
  }

  bookAllCourse() {
    setState(() {
      isLoading = true;
    });
    List<Bookings> bookings = [];

    for (Courses c in myCart) {
      int index =
          courses.indexWhere((element) => element.instanceId == c.instanceId);
      if (index > -1) {
        bookings.add(Bookings(instanceId: courses[index].instanceId));
        courses[index].isBooked = true;
        prefs.setString('courses', jsonEncode(courses));
      }
    }
    removeCourseFromCart(myCart);

    Payload payload = Payload(
      userId: CONSTANTS().userId,
      b2: "Submit",
      bookingList: bookings,
    );

    apiService.bookCourse(payload).whenComplete(() => Fluttertoast.showToast(
        msg: "Courses booked successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0));

    setState(() {
      isLoading = false;
    });
  }

  removeCourseFromCart(List<Courses> cart) {
    myCart = [];

    List items = myCart.map((e) => e.toJson()).toList();
    prefs.setString('myCart', jsonEncode(items));
    widget.updateCartValue(myCart.length);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMyCart();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    child: Text(
                      'My Cart',
                      style: TextStyle(
                          fontSize: 28.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? Container(
                          height: displayHeight - 180,
                        )
                      : myCart.isNotEmpty
                          ? SizedBox(
                              height: displayHeight - 180,
                              width: displayWidth,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: myCart.length,
                                itemBuilder: (context, index) => CartCard(
                                  id: myCart[index].instanceId,
                                  time: myCart[index].classTime,
                                  classDay: myCart[index].classDay,
                                  date: myCart[index].date,
                                  teacher: myCart[index].teacher,
                                  isBooked: myCart[index].isBooked,
                                  updateCart: updateCart,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: displayHeight - 180,
                              child: const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 60,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Your cart is empty',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          bookAllCourse();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.secondaryButtonDark,
                          foregroundColor: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Book all courses',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
