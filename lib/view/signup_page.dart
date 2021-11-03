import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/auth.dart';
import 'package:e_wallet_app/services/db.dart';
import 'package:e_wallet_app/services/result_status.dart';
import 'package:e_wallet_app/view/home_page.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _authService = AuthService();
  final _dbService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Text Field for first name
    final firstnameField = Container(
      child: TextFormField(
        autofocus: false,
        controller: _firstNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return "First name must not be empty";
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.person,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "first name",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    //Text Field for last name
    final lastnameField = Container(
      child: TextFormField(
        autofocus: false,
        controller: _lastNameController,
        validator: (value) {
          if (value!.isEmpty) {
            return "Last name must not be empty";
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.person,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "last name",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    //Text Field for email
    final emailField = Container(
      child: TextFormField(
        autofocus: false,
        controller: _emailController,
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
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.mail_rounded,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "email",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    //Text Field for password
    final passwordField = Container(
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        controller: _passwordController,
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
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "password",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    //Text Field for confirm password
    final passwordConfirmField = Container(
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        controller: _passwordConfirmController,
        validator: (value) {
          //using exclamation mark (!) in front variable for telling flutter that the variable is not null
          //this is happen because flutter will not allow null variable as it will cause compile error
          if (value!.isEmpty) {
            return ("Please input your password");
          }
          if (value != _passwordController.text) {
            return ("Password is not the same");
          }
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.vpn_key,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "confirm password",
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                  firstnameField,
                  const SizedBox(
                    height: 20,
                  ),
                  lastnameField,
                  const SizedBox(
                    height: 20,
                  ),
                  emailField,
                  const SizedBox(
                    height: 20,
                  ),
                  passwordField,
                  const SizedBox(
                    height: 20,
                  ),
                  passwordConfirmField,
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
                      child: const Text("Sign Up"),
                      onPressed: () {
                        signUp();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: const Text(
                          "Sign In",
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

  void signUp() async {
    if (_formKey.currentState!.validate()) {
      final result = await _authService.SignUpAccount(
        _emailController.text,
        _passwordController.text,
      );
      if (result == AuthResultStatus.successful) {
        User? user = _authService.getAuthInstance().currentUser;
        UserModel userModel = UserModel(
          uid: user?.uid,
          email: user?.email,
          password: _passwordConfirmController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
        );
        _dbService.addDataToDb(Constants.dbUserCollection, userModel.toMap());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
      Fluttertoast.showToast(
          msg: AuthExceptionHandler.generateExceptionMessage(result));
    }
  }
}
