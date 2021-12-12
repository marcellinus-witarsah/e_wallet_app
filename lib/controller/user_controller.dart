import 'package:barcode_widget/barcode_widget.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/enums.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/services/auth_service.dart';
import 'package:e_wallet_app/view/common/theme_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements AuthService {
  // create a Firebase Auth instance for interacting with Firebase Auth services
  // final= mean that this is a final and private variable
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // uising database controller for interacting with DatabaseController class by using its function
  // final = mean that this is a final and "_" mean is a private variable
  final DatabaseController _databaseController = Get.put(DatabaseController());

  @override
  // TODO: implement authInstance
  FirebaseAuth get authInstance => _firebaseAuth;

  @override
  // ignore: override_on_non_overriding_member
  UserModel? _userFromFirebase(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel.fromMap({'uid': user.uid});
  }

  @override
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  @override
  // ignore: non_constant_identifier_names
  Future<UserModel?> SignInAccount(String email, String password) async {
    try {
      //using firebase function through Firebase Auth instance for sign up
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }

  @override
  // ignore: non_constant_identifier_names
  Future<UserModel?> SignUpAccount(String email, String password, data) async {
    try {
      //using firebase function through Firebase Auth instance for sign in
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // preparing data to be sent to the Firebase Firestore
      data.addAll({'email': email, 'password': password});
      _databaseController.addDataToDb(
          dbUsersCollection, data, userCredential.user?.uid);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
    return null;
  }

  @override
  // ignore: non_constant_identifier_names
  Future SignOutAccount() {
    //using firebase function through Firebase Auth instance for sign out
    return _firebaseAuth.signOut();
  }

  Future updateEmail(newEmail) {
    //using firebase function through Firebase Auth instance for sign out
    return _firebaseAuth.currentUser!.updateEmail(newEmail);
  }

  Future updatePhoneNumber(newPhoneNumber) {
    //using firebase function through Firebase Auth instance for sign out
    return _firebaseAuth.currentUser!.updatePhoneNumber(newPhoneNumber);
  }

  void signIn(email, password, formKey) async {
    //using exclamation mark (!) in front variable for telling flutter that the variable is not null
    //this is happen because flutter will not allow null variable as it will cause compile error
    if (formKey.currentState!.validate()) {
      final user = await SignInAccount(email, password);
      if (user != null) {
        Fluttertoast.showToast(msg: "Sign in successful");
        Get.toNamed("/pin", arguments: {
          'pinDesc': 'Please input pin for user verification',
          'usage': PinCodeUsage.verificationLogin,
          'destination': '/homepage',
        });
      } else {
        Fluttertoast.showToast(msg: "Wrong email or password");
      }
    }
  }

  void updateProfile(
      uid, firstName, lastName, email, phoneNumber, formKey) async {
    if (formKey.currentState!.validate()) {
      if (uid != null) {
        await _databaseController.updateUserCollection(uid, {
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
          'email': email,
        });
        await updateEmail(email);
        Get.offNamed("/profile");
      } else {
        Fluttertoast.showToast(msg: "Error");
      }
    }
  }

  Widget popUpQrCode(uid, context) {
    return AlertDialog(
      title: const Text('User QR Code'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BarcodeWidget(
            data: uid,
            barcode: Barcode.qrCode(),
            width: 300,
            height: 300,
          ),
        ],
      ),
      actions: <Widget>[
        Container(
          decoration: ThemeHelper().buttonBoxDecoration(context),
          child: ElevatedButton(
            style: ThemeHelper().buttonStyle(),
            child: Text(
              'Close'.toUpperCase(),
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  Future scanQRCode() async {
    try {
      return await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Close", true, ScanMode.QR);
    } on PlatformException {
      print("failed");
    }
  }
}
