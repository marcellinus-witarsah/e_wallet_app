import 'package:e_wallet_app/controller/authentication/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet_app/controller/services/auth.dart';
import 'package:provider/provider.dart';

//this page is a stateless as a wrapper for all wighest
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Homepage"),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  child: const Text("Sign Out"),
                  onPressed: () {
                    print(_auth.SignOutAccount());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ));
                  },
                ),
              ),
            ],
          )),
    );
  }
}

    // final authService = Provider.of<AuthService>(context);
    // late String email;
    // late String password;
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("Homepage"),
    //   ),
    //   body: Container(
    //     margin: EdgeInsets.symmetric(
    //       horizontal: 50,
    //     ),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text("Welcome Home"),
    //         const SizedBox(
    //           height: 30,
    //         ),
    //         Container(
    //           width: double.infinity,
    //           height: 50,
    //           child: RaisedButton(
    //             color: Colors.blue,
    //             textColor: Colors.white,
    //             splashColor: Colors.blueGrey,
    //             child: const Text("Log Out"),
    //             onPressed: () {},
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );