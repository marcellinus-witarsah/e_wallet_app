import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/enums.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/ui/common/theme_helper.dart';
import 'package:e_wallet_app/ui/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'profile_page.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfilePageState();
  }
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool checkedValue = false;
  bool checkboxValue = false;
  final UserController _userController = Get.put(UserController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobilePhoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: StreamBuilder<UserModel?>(
          stream: _userController.user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<DocumentSnapshot>(
                future: _databaseController.getUserData(snapshot.data?.uid),
                builder:
                    (context, AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
                  if (docSnapshot.hasData) {
                    _firstNameController.text = docSnapshot.data?['first_name'];
                    _lastNameController.text = docSnapshot.data?['last_name'];
                    _mobilePhoneNumberController.text =
                        docSnapshot.data?['phone_number'];
                    _emailController.text = docSnapshot.data?['email'];
                    return Stack(
                      children: [
                        // ignore: sized_box_for_whitespace
                        Container(
                          height: 150,
                          // ignore: prefer_const_constructors
                          child: HeaderWidget(
                              150, false, Icons.person_add_alt_1_rounded),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
                          padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              border: Border.all(
                                                  width: 5,
                                                  color: Colors.white),
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
                                              color: Colors.grey.shade300,
                                              size: 80.0,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                80, 80, 0, 0),
                                            child: Icon(
                                              Icons.add_circle,
                                              color: Colors.grey.shade700,
                                              size: 25.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: _firstNameController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('First Name',
                                                'Enter your first name'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "First name must not be empty";
                                          }
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration('Last Name',
                                                'Enter your last name'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Last name must not be empty";
                                          }
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      child: TextFormField(
                                        controller: _emailController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                "E-mail address",
                                                "Enter your email"),
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please input your email");
                                          }
                                          if (!RegExp(
                                                  r"^[a-zA-z0-9!#$%&'*+-/=?^_`{|]+@[a-zA-z0-9-]+.[a-z]")
                                              .hasMatch(value)) {
                                            return ("Please enter valid email");
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      child: TextFormField(
                                        controller:
                                            _mobilePhoneNumberController,
                                        decoration: ThemeHelper()
                                            .textInputDecoration(
                                                "Mobile Number",
                                                "Enter your mobile number"),
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return ("Please input your phone number");
                                          }
                                          if (!RegExp(r"^[0-9]{10,11}")
                                              .hasMatch(value)) {
                                            return ("Please enter valid Phone Number");
                                          }
                                          return null;
                                        },
                                      ),
                                      decoration: ThemeHelper()
                                          .inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      decoration: ThemeHelper()
                                          .buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              40, 10, 40, 10),
                                          child: Text(
                                            "Save Changes".toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          _userController.updateProfile(
                                            snapshot.data?.uid,
                                            _firstNameController.text,
                                            _lastNameController.text,
                                            _emailController.text,
                                            _mobilePhoneNumberController.text,
                                            _formKey,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
