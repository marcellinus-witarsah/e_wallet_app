import 'package:e_wallet_app/controller/authentication/sign_in.dart';
import 'package:e_wallet_app/controller/home/homepage.dart';
import 'package:e_wallet_app/controller/services/auth.dart';
import 'package:e_wallet_app/model/user_model.dart';
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.person,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "firstname",
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
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          prefixIcon: Icon(
            Icons.person,
            color: secondaryColor,
          ),
          border: OutlineInputBorder(),
          labelText: "lastname",
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
                        onTap: () {},
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

  void signUp() {
    _authService.SignUpAccount(_emailController.text, _passwordController.text);
    User? user = _authService.getAuthInstance().currentUser;
    UserModel userModel = UserModel(
      uid: user?.uid,
      email: user?.email,
      password: _passwordController.text,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
    );
    userModel.addUserToFirestore();
    Fluttertoast.showToast(msg: "sign up successful");
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
  }
}
