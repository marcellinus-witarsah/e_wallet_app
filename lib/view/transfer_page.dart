import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _userDestinationController = TextEditingController();
    final _nominalTransferController = TextEditingController();
    final _messageTransferController = TextEditingController();
    final _auth = Provider.of<FirebaseAuthService>(context);
    final _userModel = Provider.of<UserModel?>(context);

    void transferMoney(receiverEmail, amount, desc, userModel) async {
      //using exclamation mark (!) in front variable for telling flutter that the variable is not null
      //this is happen because flutter will not allow null variable as it will cause compile error
      if (_formKey.currentState!.validate()) {
        dynamic msg =
            await userModel.transfer(receiverEmail, double.parse(amount), desc);
        if (msg == "Transaction Successful") {
          Navigator.pop(context);
        }
        Fluttertoast.showToast(msg: msg);
      }
    }

    final userDestination = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _userDestinationController,
        //adding validator for email
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please input user destination");
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "Input user destination",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    final nominalTransfer = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _nominalTransferController,
        //adding validator for email
        validator: (value) {
          if (value!.isEmpty) {
            return ("please input amount");
          }
          if (double.parse(value) < 10000) {
            return ("Transaction must be at least 10.000");
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "Amount",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    final messageTransfer = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _messageTransferController,
        //adding validator for email
        validator: (value) {
          if (value!.length > 50) {
            return ("message can't be more than 50 characters");
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "Message (optional)",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userDestination,
                  const SizedBox(
                    height: 20,
                  ),
                  nominalTransfer,
                  const SizedBox(
                    height: 20,
                  ),
                  messageTransfer,
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      child: const Text("Next"),
                      onPressed: () async {
                        dynamic message = _messageTransferController.text;
                        if (message.isEmpty) {
                          message = "transfer to other user";
                        }
                        transferMoney(
                            _userDestinationController.text,
                            _nominalTransferController.text,
                            message,
                            _userModel);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Sign In"),
    //   ),
    //   body: Center(
    //     child: SingleChildScrollView(
    //       child: Container(
    //         margin: const EdgeInsets.symmetric(
    //           horizontal: 40,
    //         ),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: <Widget>[
    //               userDestination,
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               nominalTransfer,
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               messageTransfer,
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Container(
    //                 width: double.infinity,
    //                 height: 50,
    //                 child: RaisedButton(
    //                   color: Colors.blue,
    //                   textColor: Colors.white,
    //                   splashColor: Colors.blueGrey,
    //                   child: const Text("Next"),
    //                   onPressed: () async {
    //                     dynamic message = _messageTransferController.text;
    //                     if (message.isEmpty) {
    //                       message = "transfer to other user";
    //                     }
    //                     transferMoney(_userDestinationController.text,
    //                         _nominalTransferController.text, message);
    //                   },
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

// StreamBuilder<UserModel?>(
//         stream: auth.user,
//         builder: (_, AsyncSnapshot<UserModel?> snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             final UserModel? user = snapshot.data;
//             return user == null ? SignIn() : Homepage();
//           } else {
//             return const Scaffold(
//               body: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             );
//           }
//         });