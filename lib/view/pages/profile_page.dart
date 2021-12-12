import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/view/common/theme_helper.dart';
import 'package:e_wallet_app/view/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  final UserController _userController = Get.put(UserController());
  final DatabaseController _databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<UserModel?>(
          stream: _userController.user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<DocumentSnapshot>(
                future: _databaseController.getUserData(snapshot.data!.uid),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot> docSnapshot) {
                  if (docSnapshot.hasData) {
                    return Stack(
                      children: [
                        Container(
                          height: 150,
                          child: HeaderWidget(150, false, Icons.house_rounded),
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          padding: const EdgeInsets.fromLTRB(10, 130, 10, 0),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                '${docSnapshot.data?['first_name']} ${docSnapshot.data?['last_name']}',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 4.0),
                                      alignment: Alignment.topLeft,
                                      child: const Text(
                                        "User Information",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Card(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                ...ListTile.divideTiles(
                                                  color: Colors.grey,
                                                  tiles: [
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.email),
                                                      title:
                                                          const Text("Email"),
                                                      subtitle: Text(
                                                          "${docSnapshot.data?['email']}"),
                                                    ),
                                                    ListTile(
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 12,
                                                              vertical: 4),
                                                      leading: const Icon(
                                                          Icons.password_sharp),
                                                      title: const Text(
                                                          "Password"),
                                                      subtitle: Text(
                                                        '*' *
                                                            docSnapshot
                                                                .data?[
                                                                    'password']
                                                                .length,
                                                      ),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.phone),
                                                      title: const Text(
                                                          "Mobile Phone"),
                                                      subtitle: Text(
                                                          "${docSnapshot.data?['phone_number']}"),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 45),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(Icons.qr_code),
                                              Text(
                                                'Show QR Code'.toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return _userController
                                                    .popUpQrCode(
                                                        snapshot.data?.uid,
                                                        context);
                                              });
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            'Edit Profile'.toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.offNamed("/editprofile");
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  }
                  return costumizedCircularIndicator;
                },
              );
            }
            return costumizedCircularIndicator;
          },
        ),
      ),
    );
  }
}
