import 'package:async/async.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/enums.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TransactionResult extends StatefulWidget {
  const TransactionResult({Key? key}) : super(key: key);

  @override
  _TransactionResultState createState() => _TransactionResultState();
}

class _TransactionResultState extends State<TransactionResult> {
  final UserController _userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    final _arguments = ModalRoute.of(context)!.settings.arguments as Map;

    Future commitTransaction(userModel, data) {
      dynamic msg = "There's an error occured";
      switch (_arguments['transaction_type']) {
        case TransactionType.topup:
          msg = userModel.topUp(double.parse(data['amount']), "top up");
          // Fluttertoast.showToast(msg: msg);
          // if (msg == "Top Up Successful") {
          //   Navigator.pop(context);
          // }
          if (msg == successful) {
            msg = "Top up is succesfull";
          }
          break;
        case TransactionType.transfer:
          msg = userModel.transfer(data['receiver_email'],
              double.parse(data['amount']), data['desc']);
          // Fluttertoast.showToast(msg: msg);
          if (msg == successful) {
            msg = "Transfer money is succesfull";
          }
          break;
      }
      return msg;
    }

    return Scaffold(
      body: StreamBuilder<UserModel?>(
          stream: _userController.user,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              if (_arguments['is_verified']) {
                return FutureBuilder<dynamic>(
                    future:
                        commitTransaction(snapshot.data, _arguments['data']),
                    builder: (context, msgSnapshot) {
                      if (msgSnapshot.hasData) {
                        _arguments['is_verified'] = false;
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(msgSnapshot.data),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/homepage');
                                },
                                child: const Text("homepage"),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              CircularProgressIndicator(),
                            ],
                          ),
                        );
                      }
                    });
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Text("User is unidentified"),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            );
          }),
    );
  }
}
