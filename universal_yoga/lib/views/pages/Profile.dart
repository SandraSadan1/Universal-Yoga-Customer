import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final PageController mainMenuController;

  const Profile({super.key, required this.mainMenuController});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    double displayHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Text(
                  'My Profile',
                  style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: displayHeight / 7,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20.0),
                      child: Container(
                        height: 90,
                        width: 90,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // border: Border.all(color: ConstantColors.appBg.withOpacity(0.7),width: 2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(100),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'Name: ',
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Ethan',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'E-Mail: ',
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'ethan@gmail.com',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'Age: ',
                            children: <InlineSpan>[
                              TextSpan(
                                text: '27',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: displayHeight / 2,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black12,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.account_circle_outlined,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12.withOpacity(0.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          widget.mainMenuController.jumpToPage(2);
                        },
                        splashColor: Colors.black12,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_cart_outlined,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'My Bookings',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12.withOpacity(0.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.black12,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'About',
                                  style: TextStyle(fontSize: 18),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.black12.withOpacity(0.1),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Text('\u00a9 2023, Yoga v1.0.0'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
