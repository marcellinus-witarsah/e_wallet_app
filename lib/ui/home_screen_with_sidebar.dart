import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/main.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/ui/home_screen.dart';
import 'package:e_wallet_app/ui/pages/login_page.dart';
import 'package:e_wallet_app/ui/transaction_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSidebar(),
    );
  }
}

class homeWithSidebar extends StatefulWidget {
  @override
  _homeWithSidebarState createState() => _homeWithSidebarState();
}

class _homeWithSidebarState extends State<homeWithSidebar>
    with TickerProviderStateMixin {
  bool sideBarActive = false;
  late AnimationController rotationController;
  final UserController _userController = Get.put(UserController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  @override
  void initState() {
    // TODO: implement initState
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Row navigatorTitle(String name, pageRoute) {
      return Row(
        children: [
          const SizedBox(
            width: 10,
            height: 60,
          ),
          InkWell(
              onTap: () {
                Get.toNamed(pageRoute);
              },
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ))
        ],
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff1f3f6),
      body: StreamBuilder<UserModel?>(
        stream: _userController.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot>(
                future: _databaseController.getUserData(snapshot.data?.uid),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {
                  if (docSnapshot.hasData) {
                    return Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 20),
                                  height: 150,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(60)),
                                      color: Colors.white),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xfff1f3f6),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'asset/images/avatar4.png'),
                                                  fit: BoxFit.contain)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "${docSnapshot.data?['first_name']} ${docSnapshot.data?['last_name']}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              "${docSnapshot.data?['phone_number']}",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey),
                                            )
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  navigatorTitle("Home", "/homepage"),
                                  navigatorTitle("Profile", "/profile"),
                                  navigatorTitle("Accounts", "/homepage"),
                                  navigatorTitle(
                                      "Transactions", "/transaction_history"),
                                  navigatorTitle("Stats", "/homepage"),
                                  navigatorTitle("Settings", "/homepage"),
                                  navigatorTitle("Help", "/homepage"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _userController.SignOutAccount();
                                // Navigator.pushNamed(context, '/signin');
                                Get.offAllNamed("/");
                              },
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: const <Widget>[
                                    Icon(
                                      Icons.power_settings_new,
                                      size: 30,
                                    ),
                                    Text(
                                      "Logout",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(20),
                              child: const Text(
                                "Ver 1.0.0",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: (sideBarActive)
                              ? MediaQuery.of(context).size.width * 0.6
                              : 0,
                          top: (sideBarActive)
                              ? MediaQuery.of(context).size.height * 0.2
                              : 0,
                          child: RotationTransition(
                            turns: (sideBarActive)
                                ? Tween(begin: -0.05, end: 0.0)
                                    .animate(rotationController)
                                : Tween(begin: 0.0, end: -0.05)
                                    .animate(rotationController),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: (sideBarActive)
                                  ? MediaQuery.of(context).size.height * 0.7
                                  : MediaQuery.of(context).size.height,
                              width: (sideBarActive)
                                  ? MediaQuery.of(context).size.width * 0.8
                                  : MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Colors.white),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40)),
                                child: HomeScreen(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 20,
                          child: (sideBarActive)
                              ? IconButton(
                                  padding: const EdgeInsets.all(30),
                                  onPressed: closeSideBar,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                )
                              : InkWell(
                                  onTap: openSideBar,
                                  child: Container(
                                    margin: const EdgeInsets.all(17),
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'asset/images/menu.png'))),
                                  ),
                                ),
                        )
                      ],
                    );
                  }
                  return costumizedCircularIndicator;
                });
          }
          return costumizedCircularIndicator;
        },
      ),
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    setState(() {});
  }
}
