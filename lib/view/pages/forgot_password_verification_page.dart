import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/enums.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/view/common/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'profile_page.dart';
import 'widgets/header_widget.dart';

class UserVerificationPage extends StatefulWidget {
  const UserVerificationPage({Key? key}) : super(key: key);

  @override
  _UserVerificationPageState createState() => _UserVerificationPageState();
}

class _UserVerificationPageState extends State<UserVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;
  int counterWrongPin = 3;
  String _pinValue = "";
  double _headerHeight = 300;

  @override
  Widget build(BuildContext context) {
    // final FirebaseAuthService _auth = Provider.of<FirebaseAuthService>(context);
    final UserController _userController = Get.put(UserController());
    final DatabaseController _databaseController =
        Get.put(DatabaseController());
    TextEditingController _pinController = TextEditingController();
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final arguments = Get.arguments as Map<String, dynamic>;

    final Widget costumizedCircularIndicator = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffffac30)),
          )
        ],
      ),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<UserModel?>(
          stream: _userController.user,
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return FutureBuilder<DocumentSnapshot?>(
                future: _databaseController.getUserData(snapshot.data?.uid),
                builder: (_, AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
                  if (docSnapshot.hasData) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: _headerHeight,
                            child: HeaderWidget(_headerHeight, true,
                                Icons.privacy_tip_outlined),
                          ),
                          SafeArea(
                            child: Container(
                              margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Pin Security',
                                          style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                          // textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          arguments['pinDesc'],
                                          style: const TextStyle(
                                              // fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                          // textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 40.0),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        PinCodeTextField(
                                          appContext: context,
                                          pastedTextStyle: TextStyle(
                                            color: HexColor('#f7bc3b'),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          length: 6,
                                          obscureText: true,
                                          obscuringCharacter: '*',
                                          animationType: AnimationType.fade,
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            fieldHeight: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6.0,
                                            fieldWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8.0,
                                          ),
                                          autoFocus: true,
                                          textStyle: const TextStyle(
                                              fontSize: 20, height: 1.6),
                                          // enableActiveFill: true,
                                          keyboardType: TextInputType.number,
                                          onCompleted: (value) {
                                            _pinValue = value;
                                            _pinSuccess = true;
                                          },
                                          onChanged: (String value) {
                                            _pinSuccess = false;
                                          },
                                        ),
                                        const SizedBox(height: 40.0),
                                        Container(
                                          decoration: _pinSuccess
                                              ? ThemeHelper()
                                                  .buttonBoxDecoration(context)
                                              : ThemeHelper()
                                                  .buttonBoxDecoration(context,
                                                      "#AAAAAA", "#757575"),
                                          child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 10, 40, 10),
                                              child: Text(
                                                "Submit Pin".toUpperCase(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              print(arguments['pinDesc']);
                                              print(arguments['destination']);
                                              print(arguments['usage']);
                                              print(arguments['data']);
                                              print(_pinValue);
                                              if (counterWrongPin == 0) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "You are not a real user");
                                                // Navigator.pushNamed(
                                                //     context, '/myhomepage');
                                                Get.offAllNamed("/");
                                              } else if (arguments['usage'] ==
                                                  PinCodeUsage.create) {
                                                print(await _databaseController
                                                    .updateUserCollection(
                                                        snapshot.data!.uid, {
                                                  'pin_code': _pinValue
                                                }));
                                                // Navigator.pushNamed(
                                                //   context,
                                                //   arguments['destination'],
                                                // );
                                                Get.offNamed(
                                                    arguments['destination']);
                                              } else if (arguments['usage'] ==
                                                  PinCodeUsage
                                                      .verificationTransaction) {
                                                if (_pinValue ==
                                                    docSnapshot
                                                        .data!['pin_code']) {
                                                  Fluttertoast.showToast(
                                                      msg: "pin is correct");

                                                  // Navigator.pushNamed(context,
                                                  //     arguments['destination'],
                                                  //     arguments: {
                                                  //       'is_verified': true,
                                                  //       'transaction_type':
                                                  //           arguments[
                                                  //               'transaction_type'],
                                                  //       'data':
                                                  //           arguments['data'],
                                                  //     });

                                                  Get.offNamed(
                                                      arguments['destination'],
                                                      arguments: {
                                                        'is_verified': true,
                                                        'transaction_type':
                                                            arguments[
                                                                'transaction_type'],
                                                        'data':
                                                            arguments['data'],
                                                      });
                                                }
                                              } else if (arguments['usage'] ==
                                                  PinCodeUsage
                                                      .verificationLogin) {
                                                if (_pinValue ==
                                                    docSnapshot
                                                        .data!['pin_code']) {
                                                  print(
                                                      "masuk ${arguments['destination']}");
                                                  Fluttertoast.showToast(
                                                      msg: "pin is correct");
                                                  // Navigator.pushNamed(
                                                  //   context,
                                                  //   arguments['destination'],
                                                  // );
                                                  Get.offNamed(
                                                      arguments['destination']);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "pin is incorrect ${counterWrongPin} remaining attemps left");
                                                  counterWrongPin--;
                                                  print(_pinValue);
                                                }
                                              } else {}
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return costumizedCircularIndicator;
                },
              );
            }
            return costumizedCircularIndicator;
          },
        ));
  }
}
