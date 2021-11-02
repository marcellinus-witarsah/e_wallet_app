import 'package:e_wallet_app/controller/authentication/sign_up.dart';
import 'package:e_wallet_app/controller/home/homepage.dart';
import 'package:e_wallet_app/controller/services/auth.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

final primaryColor = Colors.white;
final secondaryColor = Colors.black54;

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //global key is used for vaildating user input inside each text field according to its validation rules
  final _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //for capture or store value that user has input in the text field
    final emailField = Container(
      child: TextFormField(
        autofocus: false,
        //using controller for listen and capture email input from user
        controller: _emailController,
        //adding validator for email
        validator: (value) {
          //using exclamation mark (!) in front variable for telling flutter that the variable is not null
          //this is happen because flutter will not allow null variable as it will cause compile error
          if (value!.isEmpty) {
            return ("Please input your email");
          }
          if (!RegExp(r"^[a-zA-z0-9!#$%&'*+-/=?^_`{|]+@[a-zA-z0-9-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter valid email");
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "email",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    final passwordField = Container(
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        //using controller for listen and capture password input from user
        controller: _passwordController,
        //adding validator for password
        validator: (value) {
          //using exclamation mark (!) in front variable for telling flutter that the variable is not null
          //this is happen because flutter will not allow null variable as it will cause compile error
          if (value!.isEmpty) {
            return ("Please input your password");
          }
          if (value.length < 6) {
            return ("Password must be at least 6 characters");
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: secondaryColor,
          ),
          border: const OutlineInputBorder(),
          labelText: "password",
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
                  emailField,
                  const SizedBox(
                    height: 20,
                  ),
                  passwordField,
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
                      child: const Text("Sign In"),
                      onPressed: () {
                        signIn(
                          _emailController.text,
                          _passwordController.text,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("You dont't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(
    email,
    password,
  ) {
    //using exclamation mark (!) in front variable for telling flutter that the variable is not null
    //this is happen because flutter will not allow null variable as it will cause compile error
    if (_formKey.currentState!.validate()) {
      _auth.SignInAccount(email, password)
          .then((user) => {
                print("user = ${user}"),
                Fluttertoast.showToast(msg: "Sign Successful"),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ))
              })
          .catchError((e) {
        //flutter toast for showing message
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
