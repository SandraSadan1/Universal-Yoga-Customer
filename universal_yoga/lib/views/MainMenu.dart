import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:universal_yoga/models/Courses.dart';
import 'package:universal_yoga/utils/ConstantColors.dart';
import 'package:universal_yoga/utils/services/ApiService.dart';
import 'package:universal_yoga/views/pages/CourseCategories.dart';
import 'package:universal_yoga/views/pages/HomeScreen.dart';
import 'package:universal_yoga/views/pages/MyBookings.dart';
import 'package:universal_yoga/views/pages/Profile.dart';

import '../utils/helpers/Helpers.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final PageController mainMenuController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageView(
        controller: mainMenuController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            pageIndex = page;
          });
        },
        children: <Widget>[
          const Home(),
          const CourseCategories(),
          const MyBookings(),
          Profile(
            mainMenuController: mainMenuController,
          )
        ],
      ),
      bottomNavigationBar: Provider.of<Helpers>(context)
          .customNavBar(pageIndex, displayWidth, mainMenuController),
    );
  }
}
