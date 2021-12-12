// //for authentication services

// import 'package:e_wallet_app/constants.dart';
// import 'package:e_wallet_app/model/user_model.dart';
// import 'package:e_wallet_app/services/auth_service.dart';
// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:e_wallet_app/services/result_status.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService implements AuthService {
//   //create a Firebase Auth instance for interacting with Firebase Auth services
//   //final= mean that this is a final and private variable
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseDatabaseService _db = FirebaseDatabaseService();
//   // late AuthResultStatus _status;

//   @override
//   // TODO: implement authInstance
//   FirebaseAuth get authInstance => _firebaseAuth;

//   @override
//   UserModel? _userFromFirebase(User? user) {
//     if (user == null) {
//       return null;
//     }
//     return UserModel(user.uid);
//   }

//   @override
//   Stream<UserModel?> get user {
//     return _firebaseAuth.authStateChanges().map(_userFromFirebase);
//   }

//   @override
//   Future<UserModel?> SignInAccount(String email, String password) async {
//     try {
//       //using firebase function through Firebase Auth instance for sign up
//       final UserCredential userCredential =
//           await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return _userFromFirebase(userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   @override
//   Future<UserModel?> SignUpAccount(String email, String password, data) async {
//     try {
//       //using firebase function through Firebase Auth instance for sign in
//       final UserCredential userCredential =
//           await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       // preparing data to be sent to the Firebase Firestore
//       data.addAll({'email': email, 'password': password});
//       _db.addDataToDb(
//           Constants.dbUsersCollection, data, userCredential.user?.uid);
//       return _userFromFirebase(userCredential.user);
//     } on FirebaseAuthException catch (e) {
//       print(e.toString());
//     }
//     return null;
//   }

//   @override
//   Future SignOutAccount() {
//     //using firebase function through Firebase Auth instance for sign out
//     return _firebaseAuth.signOut();
//   }
// }

//   // //sign up
//   // Future<AuthResultStatus> SignUpAccount(String email, String password) async {
//   //   try {
//   //     //using firebase function through Firebase Auth instance for sign up
//   //     final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     if (authResult.user != null) {
//   //       _status = AuthResultStatus.successful;
//   //     } else {
//   //       _status = AuthResultStatus.undefined;
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     _status = AuthExceptionHandler.handleException(e);
//   //   }
//   //   return _status;
//   // }

//   // //log in
//   // Future<AuthResultStatus> SignInAccount(String email, String password) async {
//   //   try {
//   //     //using firebase function through Firebase Auth instance for sign in
//   //     final authResult = await _firebaseAuth.signInWithEmailAndPassword(
//   //       email: email,
//   //       password: password,
//   //     );
//   //     if (authResult.user != null) {
//   //       _status = AuthResultStatus.successful;
//   //     } else {
//   //       _status = AuthResultStatus.undefined;
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     print(e.toString());
//   //     _status = AuthExceptionHandler.handleException(e);
//   //   }
//   //   return _status;
//   // }

//   // //sign out
//   // Future SignOutAccount() async {
//   //   //using firebase function through Firebase Auth instance for sign out
//   //   return _firebaseAuth.signOut();
//   // }