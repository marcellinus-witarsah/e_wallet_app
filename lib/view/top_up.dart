import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:e_wallet_app/view/verification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class TopUp extends StatefulWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  @override
  Widget build(BuildContext context) {
    final _nominalTopUpController = TextEditingController();
    final _auth = Provider.of<FirebaseAuthService>(context);
    // final _userModel = Provider.of<UserModel?>(context);
    final _formKey = GlobalKey<FormState>();
    final _arguments = ModalRoute.of(context)?.settings.arguments as Map;

    void topUpMoney(amount, userModel) async {
      if (_formKey.currentState!.validate()) {
        dynamic msg = await userModel.topUp(
            double.parse(_nominalTopUpController.text), "top up");
        if (msg == "Top Up Successful") {
          Navigator.pop(context);
        }
        Fluttertoast.showToast(msg: msg);
      }
    }

    final nominalTopUp = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _nominalTopUpController,
        //change keyboard for number only
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.isEmpty) {
            return ("please input amount");
          }
          if (double.parse(value) < 10000) {
            return ("Transaction must be at least 10.000");
          }
        },
        //adding validator for email
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.money,
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
    if (_arguments['verified']) {
      return StreamBuilder<UserModel?>(
        stream: _auth.user,
        builder: (context, snapshot) {
          topUpMoney(_arguments['amount'], snapshot.data);

          return TopUpSuccesfullPage();
        },
      );
      // topUpMoney(
      //   _arguments['amount'],
      // );
      // return Text("lalala : ${_arguments['amount']}");
    }
    return StreamBuilder<UserModel?>(
        stream: _auth.user,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Top Up Money"),
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
                        Text("${_arguments['verified']}"),
                        Text("${_arguments['amount']}"),
                        nominalTopUp,
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
                            child: const Text("Top Up"),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/pin',
                                  arguments: {
                                    'amount': _nominalTopUpController.text,
                                    'destination': '/topup',
                                    'usage': PinCodeUsage.verification
                                  });
                              // topUpMoney(
                              //     double.parse(_nominalTopUpController.text),
                              //     snapshot.data);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class TopUpSuccesfullPage extends StatelessWidget {
  const TopUpSuccesfullPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Top Up Succesfull"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homepage');
              },
              child: Text("homepage"),
            )
          ],
        ),
      ),
    );
  }
}
