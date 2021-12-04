import 'package:e_wallet_app/model/user_model.dart';
import 'package:e_wallet_app/services/firebase_database_service.dart';
import 'package:e_wallet_app/services/firebase_auth_service.dart';
import 'package:e_wallet_app/view/home_page.dart';
import 'package:e_wallet_app/view/profile_edit_page.dart';
import 'package:e_wallet_app/view/signin_page.dart';
import 'package:e_wallet_app/view/signup_page.dart';
import 'package:e_wallet_app/view/top_up.dart';
import 'package:e_wallet_app/view/transaction_history_page.dart';
import 'package:e_wallet_app/view/transfer_page.dart';
import 'package:e_wallet_app/view/verification_page.dart';
import 'package:e_wallet_app/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // StreamProvider<UserModel?>.value(
        //   value: FirebaseAuthService().user,
        //   initialData: null,
        // ),
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        Provider<FirebaseDatabaseService>(
            create: (_) => FirebaseDatabaseService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        routes: {
          '/wrapper': (context) => Wrapper(),
          '/homepage': (context) => Homepage(),
          '/topup': (context) => TopUp(),
          '/transfer': (context) => Transfer(),
          '/profile': (context) => ProfilePage(),
          '/profile_edit': (context) => ProfileEditPage(),
          '/signin': (context) => SignIn(),
          '/signup': (context) => SignUp(),
          '/transaction_history': (context) => TransactionHistory(),
          '/pin': (context) => PinCodePage(),
        },
      ),
    );
  }
}
