import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import '../../models/Courses.dart';
import '../../views/courses/CourseList.dart';

class Helpers with ChangeNotifier {
  Widget smallDot() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 3,
        height: 3,
        decoration: const BoxDecoration(
            color: ConstantColors.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(50))),
      ),
    );
  }

  Widget customNavBar(
      int currentIndex, double displayWidth, PageController pageController) {
    List<IconData> bottomBarIcons = [
      Icons.home_rounded,
      Icons.category_rounded,
      Icons.shopping_cart_rounded,
      Icons.person
    ];

    List<String> labels = ['Home', 'Courses', 'Bookings', 'Account'];
    return Container(
      margin: EdgeInsets.fromLTRB(displayWidth * .05, displayWidth * .01,
          displayWidth * .05, displayWidth * .03),
      height: displayWidth * .155,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.builder(
        itemCount: bottomBarIcons.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            currentIndex = index;
            pageController.jumpToPage(index);
            notifyListeners();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == currentIndex
                    ? displayWidth * .32
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: index == currentIndex ? displayWidth * .12 : 0,
                  width: index == currentIndex ? displayWidth * .32 : 0,
                  decoration: BoxDecoration(
                    color: index == currentIndex
                        ? ConstantColors.secondaryButtonDark.withOpacity(.2)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.fastLinearToSlowEaseIn,
                width: index == currentIndex
                    ? displayWidth * .31
                    : displayWidth * .18,
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width: index == currentIndex ? displayWidth * .13 : 0,
                        ),
                        AnimatedOpacity(
                          opacity: index == currentIndex ? 1 : 0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          child: Text(
                            index == currentIndex ? labels[index] : '',
                            style: const TextStyle(
                              color: ConstantColors.secondaryButtonDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          width:
                              index == currentIndex ? displayWidth * .03 : 20,
                        ),
                        Icon(
                          bottomBarIcons[index],
                          size: displayWidth * .076,
                          color: index == currentIndex
                              ? ConstantColors.secondaryButtonDark
                              : Colors.black26,
                        ),
                      ],
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

  Widget categoryTile(
    BuildContext context,
    String title,
    double displayWidth,
    double displayHeight,
    String image,
    Color bgColor,
    bool isLeft,
    List<Courses> courses,
  ) {
    return Column(
      children: [
        Container(
          height: displayHeight / 7,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 8,
                spreadRadius: 4,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment:
                    !isLeft ? Alignment.centerLeft : Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.pacifico(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            width: 2.0,
                            color: ConstantColors.secondaryButtonDark,
                          ),
                        ),
                        child: Text(
                          'View Courses',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: ConstantColors.secondaryButtonDark,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: CourseList(),
                              type: PageTransitionType.rightToLeftWithFade,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment:
                    isLeft ? Alignment.centerLeft : Alignment.centerRight,
                child: SizedBox(
                  width: displayWidth / 2,
                  height: displayWidth / 2,
                  child: SvgPicture.asset(image),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
