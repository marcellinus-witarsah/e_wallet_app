// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/view/home_page.dart';
// import 'package:e_wallet_app/view/profile_edit_page.dart';
// import 'package:e_wallet_app/view/qr_page.dart';
// import 'package:e_wallet_app/view/signin_page.dart';
// import 'package:e_wallet_app/view/signup_page.dart';
// import 'package:e_wallet_app/view/top_up.dart';
// import 'package:e_wallet_app/view/transaction_history_page.dart';
// import 'package:e_wallet_app/view/transaction_result.dart';
// import 'package:e_wallet_app/view/transfer_page.dart';
// import 'package:e_wallet_app/view/verification_page.dart';
// import 'package:e_wallet_app/wrapper.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         // StreamProvider<UserModel?>.value(
//         //   value: FirebaseAuthService().user,
//         //   initialData: null,
//         // ),
//         Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
//         Provider<FirebaseDatabaseService>(
//             create: (_) => FirebaseDatabaseService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Wrapper(),
//         routes: {
//           '/wrapper': (context) => Wrapper(),
//           '/homepage': (context) => const Homepage(),
//           '/topup': (context) => const TopUp(),
//           '/transfer': (context) => const Transfer(),
//           '/profile': (context) => const ProfilePage(),
//           '/profile_edit': (context) => const ProfileEditPage(),
//           '/signin': (context) => const SignIn(),
//           '/signup': (context) => const SignUp(),
//           '/transaction_history': (context) => const TransactionHistory(),
//           '/pin': (context) => const PinCodePage(),
//           '/transaction_result': (context) => const TransactionResult(),
//           '/qr': (context) => const QRPage(),
//         },
//       ),
//     );
//   }
// }

import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/transaction_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/ui/home_screen.dart';
import 'package:e_wallet_app/ui/pages/edit_profile_page.dart';
import 'package:e_wallet_app/ui/pages/forgot_password_verification_page.dart';
import 'package:e_wallet_app/ui/pages/login_page.dart';
import 'package:e_wallet_app/ui/pages/profile_page.dart';
import 'package:e_wallet_app/ui/pages/registration_page.dart';
import 'package:e_wallet_app/ui/pages/splash_screen.dart';
import 'package:e_wallet_app/ui/topup_screen.dart';
import 'package:e_wallet_app/ui/transaction_history_screen.dart';
import 'package:e_wallet_app/ui/transaction_result.dart';
import 'package:e_wallet_app/ui/transfer_screen.dart';
import 'package:e_wallet_app/view/home_page.dart';
import 'package:e_wallet_app/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet_app/ui/home_screen_with_sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    UserController _userController = Get.put(UserController());
    _userController.SignOutAccount();
    _userController.SignInAccount("asd@gmail.com", "Optimus2810");
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login UI',
      // initialRoute: '/myhomepage',
      home: Wrapper(),
      getPages: [
        GetPage(name: '/', page: () => MyHomePage()),
        GetPage(
            name: '/transaction_history', page: () => TransactionHistoryPage()),
        GetPage(name: '/signin', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => RegistrationPage()),
        GetPage(name: '/pin', page: () => const UserVerificationPage()),
        GetPage(name: '/homepage', page: () => HomeWithSidebar()),
        GetPage(
            name: '/transaction_result', page: () => const TransactionResult()),
        GetPage(name: '/topup', page: () => TopUpPage()),
        GetPage(name: '/transfer', page: () => TransferPage()),
        GetPage(name: '/profile', page: () => ProfilePage()),
        GetPage(name: '/editprofile', page: () => EditProfilePage()),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // DateTime now = DateTime.now();
  final time = DateFormat.jm().format(DateTime.now());
  final day = DateFormat.yMMMMEEEEd().format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            // ignore: prefer_const_constructors
            decoration: BoxDecoration(
                // ignore: prefer_const_constructors
                image: DecorationImage(
                    // ignore: prefer_const_constructors
                    image: AssetImage('asset/images/sideImg.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w500),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                // ignore: prefer_const_constructors
                Text(
                  day,
                  // ignore: prefer_const_constructors
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                Expanded(
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                              // ignore: prefer_const_constructors
                              image: DecorationImage(
                                  image:
                                      const AssetImage('asset/images/logo.png'),
                                  fit: BoxFit.contain)),
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "eWallet",
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'ubuntu',
                              fontWeight: FontWeight.w600),
                        ),
                        // ignore: prefer_const_constructors
                        SizedBox(
                          height: 10,
                        ),
                        // ignore: prefer_const_constructors
                        Text(
                          "Open An Account For \nDigital E-Wallet Solutions. \nInstant Payouts.\n\nJoin For Free",
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/signin');
                      Get.toNamed('/signin');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Text(
                          "Sign In",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 17,
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xffffac30)),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // Navigator.pushNamed(context, '/register');
                    // print("masuk");
                    Get.toNamed('/register');
                  },
                  child: Container(
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.all(20),
                    // ignore: prefer_const_constructors
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "Create an account",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
