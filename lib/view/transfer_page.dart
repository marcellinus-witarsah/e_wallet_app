import 'package:e_wallet_app/view/signin_page.dart';
import 'package:flutter/material.dart';

class Transfer extends StatelessWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userDestinationController = TextEditingController();
    final _nominalTransferController = TextEditingController();
    final _messageTransferController = TextEditingController();

    final userDestination = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _userDestinationController,
        //adding validator for email
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
                      onPressed: () {},
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
  }
}
