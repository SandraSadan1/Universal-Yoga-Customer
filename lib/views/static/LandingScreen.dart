import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/views/MainMenu.dart';

import '../../utils/Constants.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  CONSTANTS constants = CONSTANTS();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SizedBox(
                  height: (height / 3) * 1.85,
                  // width: MediaQuery.of(context).size.width,
                  child: const Image(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/home-layer.jpeg'),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Have the best',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.normal,
                          color: ConstantColors.grey1,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Yoga Experience',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: ConstantColors.black2,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20.0),
                        child: Text(
                          'Transform your body and mind with our comprehensive yoga app. Discover expert-led classes, personalized routines',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            color: ConstantColors.grey1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ConstantColors.secondaryButtonDark,
                            padding: const EdgeInsets.fromLTRB(55, 17, 55, 17)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: const MainMenu(),
                              type: PageTransitionType.rightToLeftWithFade,
                            ),
                          );
                        },
                        child: const Text(
                          'Start Journey',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.36,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
