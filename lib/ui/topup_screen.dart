import 'package:e_wallet_app/enums.dart';
import 'package:e_wallet_app/ui/common/theme_helper.dart';
import 'package:e_wallet_app/ui/pages/widgets/header_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/profile_page.dart';

class TopUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TopUpPageState();
  }
}

class _TopUpPageState extends State<TopUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  final _amountController = TextEditingController();
  Color c = HexColor("#424a7b");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  child:
                      HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
                ),
                InkWell(
                  onTap: () {
                    Get.offNamed('homepage');
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 33, 0, 0),
                    child: const Icon(
                      Icons.exit_to_app,
                      color: Color.fromRGBO(66, 74, 123, 1),
                      size: 40,
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                        Container(
                          child: TextFormField(
                            controller: _amountController,
                            decoration: ThemeHelper().textInputDecoration(
                                'Amount', 'Input top up amount'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("please input amount");
                              }
                              if (double.parse(value) < 10000) {
                                return ("Transaction must be at least 10.000");
                              }
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        const SizedBox(height: 20.0),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration:
                              ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Top Up".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Navigator.popAndPushNamed(context, '/pin',
                                //     arguments: {
                                //       'data': {
                                //         'amount': _amountController.text
                                //       },
                                //       'transaction_type': TransactionType.topup,
                                //       'destination': '/transaction_result',
                                //       'usage':
                                //           PinCodeUsage.verificationTransaction
                                //     });
                                Get.offNamed('/pin', arguments: {
                                  'data': {'amount': _amountController.text},
                                  'pinDesc':
                                      'Please input pin for user verification lalala',
                                  'transaction_type': TransactionType.topup,
                                  'destination': '/transaction_result',
                                  'usage': PinCodeUsage.verificationTransaction
                                });
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        const SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
