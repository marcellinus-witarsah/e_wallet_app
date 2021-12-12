// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:e_wallet_app/constants.dart';
// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/services/result_status.dart';
// import 'package:e_wallet_app/view/signin_page.dart';
// import 'package:e_wallet_app/view/verification_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:provider/provider.dart';

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   @override
//   Widget build(BuildContext context) {
//     final _auth = Provider.of<FirebaseAuthService>(context);
//     final _db = Provider.of<FirebaseDatabaseService>(context);
//     final _formKey = GlobalKey<FormState>();
//     final _firstNameController = TextEditingController();
//     final _lastNameController = TextEditingController();
//     final _phoneNumberController = TextEditingController();
//     final _emailController = TextEditingController();
//     final _passwordController = TextEditingController();
//     final _passwordConfirmController = TextEditingController();
//     String countryCode = "+62";

//     void signUp() async {
//       if (_formKey.currentState!.validate()) {
//         Map<String, dynamic> _data = {
//           'first_name': _firstNameController.text,
//           'last_name': _lastNameController.text,
//           'phone_number': (countryCode + _phoneNumberController.text),
//           'balance': 0,
//           'pin_code': '',
//         };
//         final result = await _auth.SignUpAccount(
//             _emailController.text, _passwordController.text, _data);
//         if (result != null) {
//           Fluttertoast.showToast(msg: "Sign up successful");
//           Navigator.popAndPushNamed(context, '/pin', arguments: {
//             'usage': PinCodeUsage.create,
//             'destination': '/signin',
//           });
//         }
//         Fluttertoast.showToast(
//             msg: AuthExceptionHandler.generateExceptionMessage(result));
//       }
//       return;
//     }

//     //Text Field for first name
//     final firstnameField = Container(
//       child: TextFormField(
//         autofocus: false,
//         controller: _firstNameController,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return "First name must not be empty";
//           }
//         },
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(20),
//           prefixIcon: Icon(
//             Icons.person,
//             color: secondaryColor,
//           ),
//           border: const OutlineInputBorder(),
//           labelText: "first name",
//           labelStyle: TextStyle(
//             color: secondaryColor,
//           ),
//         ),
//       ),
//     );

//     //Text Field for last name
//     final lastnameField = Container(
//       child: TextFormField(
//         autofocus: false,
//         controller: _lastNameController,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return "Last name must not be empty";
//           }
//         },
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.all(20),
//           prefixIcon: Icon(
//             Icons.person,
//             color: secondaryColor,
//           ),
//           border: OutlineInputBorder(),
//           labelText: "last name",
//           labelStyle: TextStyle(
//             color: secondaryColor,
//           ),
//         ),
//       ),
//     );

//     final phoneNumberField = Container(
//       child: Row(children: [
//         Expanded(
//           flex: 1,
//           child: Container(
//             child: CountryCodePicker(
//               onChanged: (country) {
//                 setState(() {
//                   countryCode = country.dialCode!;
//                 });
//               },
//               initialSelection: countryCode,
//               showCountryOnly: false,
//               showOnlyCountryWhenClosed: false,
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//         Expanded(
//           flex: 2,
//           child: TextFormField(
//             autofocus: false,
//             controller: _phoneNumberController,
//             validator: (value) {
//               //using exclamation mark (!) in front variable for telling flutter that the variable is not null
//               //this is happen because flutter will not allow null variable as it will cause compile error
//               if (value!.isEmpty) {
//                 return ("Please input your phone number");
//               }
//               if (RegExp(r"^[0]").hasMatch(value)) {
//                 return ("Don't include zero at the beginning");
//               }
//               if (!RegExp(r"^[0-9]{10,11}").hasMatch(value)) {
//                 return ("Please enter valid Phone Number");
//               }
//             },
//             decoration: InputDecoration(
//               contentPadding: const EdgeInsets.all(20),
//               border: const OutlineInputBorder(),
//               labelText: "phone number",
//               labelStyle: TextStyle(
//                 color: secondaryColor,
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );

//     //Text Field for email
//     final emailField = Container(
//       child: TextFormField(
//         autofocus: false,
//         controller: _emailController,
//         validator: (value) {
//           //using exclamation mark (!) in front variable for telling flutter that the variable is not null
//           //this is happen because flutter will not allow null variable as it will cause compile error
//           if (value!.isEmpty) {
//             return ("Please input your email");
//           }
//           if (!RegExp(r"^[a-zA-z0-9!#$%&'*+-/=?^_`{|]+@[a-zA-z0-9-]+.[a-z]")
//               .hasMatch(value)) {
//             return ("Please enter valid email");
//           }
//         },
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(20),
//           prefixIcon: Icon(
//             Icons.mail_rounded,
//             color: secondaryColor,
//           ),
//           border: const OutlineInputBorder(),
//           labelText: "email",
//           labelStyle: TextStyle(
//             color: secondaryColor,
//           ),
//         ),
//       ),
//     );

//     //Text Field for password
//     final passwordField = Container(
//       child: Column(children: [
//         TextFormField(
//           autofocus: false,
//           obscureText: true,
//           controller: _passwordController,
//           validator: (value) {
//             //using exclamation mark (!) in front variable for telling flutter that the variable is not null
//             //this is happen because flutter will not allow null variable as it will cause compile error
//             if (value!.isEmpty) {
//               return ("Please input your password");
//             }
//             if (value.length < 6) {
//               return ("Password must be at least 6 characters");
//             }
//           },
//           decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(20),
//             prefixIcon: Icon(
//               Icons.vpn_key,
//               color: secondaryColor,
//             ),
//             border: const OutlineInputBorder(),
//             labelText: "password",
//             labelStyle: TextStyle(
//               color: secondaryColor,
//             ),
//           ),
//         ),
//       ]),
//     );

//     //Text Field for confirm password
//     final passwordConfirmField = Container(
//       child: TextFormField(
//         autofocus: false,
//         obscureText: true,
//         controller: _passwordConfirmController,
//         validator: (value) {
//           //using exclamation mark (!) in front variable for telling flutter that the variable is not null
//           //this is happen because flutter will not allow null variable as it will cause compile error
//           if (value!.isEmpty) {
//             return ("Please input your password");
//           }
//           if (value != _passwordController.text) {
//             return ("Password is not the same");
//           }
//         },
//         decoration: InputDecoration(
//           contentPadding: const EdgeInsets.all(20),
//           prefixIcon: Icon(
//             Icons.vpn_key,
//             color: secondaryColor,
//           ),
//           border: const OutlineInputBorder(),
//           labelText: "confirm password",
//           labelStyle: TextStyle(
//             color: secondaryColor,
//           ),
//         ),
//       ),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sign Up"),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             margin: const EdgeInsets.symmetric(
//               horizontal: 40,
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   firstnameField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   lastnameField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   phoneNumberField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   emailField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   passwordField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   passwordConfirmField,
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       child: const Text("Sign Up"),
//                       onPressed: () {
//                         signUp();
//                       },
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       const Text("Already have an account? "),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const SignIn()));
//                         },
//                         child: const Text(
//                           "Sign In",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
