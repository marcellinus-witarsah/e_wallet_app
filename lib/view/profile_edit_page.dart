// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:e_wallet_app/model/user_model.dart';
// import 'package:e_wallet_app/services/firebase_auth_service.dart';
// import 'package:e_wallet_app/services/firebase_database_service.dart';
// import 'package:e_wallet_app/view/signin_page.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   Widget displayUserInformation(data) {
//     return Column(
//       children: <Widget>[
//         Text(
//           "First Name: ${data['first_name']}",
//           style: const TextStyle(fontSize: 20),
//         ),
//         Text(
//           "Last Name: ${data['last_name']}",
//           style: const TextStyle(fontSize: 20),
//         ),
//         Text(
//           "Phone Number: ${data['phone_number']}",
//           style: const TextStyle(fontSize: 20),
//         ),
//         Text(
//           "Email: ${data['email']}",
//           style: const TextStyle(fontSize: 20),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _auth = Provider.of<FirebaseAuthService>(context);
//     final _db = Provider.of<FirebaseDatabaseService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile Edit"),
//       ),
//       body: StreamBuilder<UserModel?>(
//         stream: _auth.user,
//         builder: (context, snapshot) {
//           print("hallo ${snapshot.data?.uid}");
//           return FutureBuilder<DocumentSnapshot?>(
//               future: _db.getUserData(snapshot.data?.uid),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
//                 if (docSnapshot.hasData) {
//                   return Center(
//                     child: SingleChildScrollView(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             // Display User Information
//                             Text(
//                               "First Name: ${docSnapshot.data?['first_name']}",
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                             Text(
//                               "Last Name: ${docSnapshot.data?['last_name']}",
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                             Text(
//                               "Phone Number: ${docSnapshot.data?['phone_number']}",
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                             Text(
//                               "Email: ${docSnapshot.data?['email']}",
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                             Container(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: const Text("Edit Profile"),
//                                 onPressed: () {
//                                   Navigator.popAndPushNamed(
//                                       context, '/profile_edit');
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               width: double.infinity,
//                               height: 50,
//                               child: RaisedButton(
//                                 color: Colors.blue,
//                                 textColor: Colors.white,
//                                 splashColor: Colors.blueGrey,
//                                 child: const Text("Sign Out"),
//                                 onPressed: () {
//                                   print(_auth.SignOutAccount());
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => SignIn(),
//                                       ));
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const <Widget>[CircularProgressIndicator()],
//                     ),
//                   );
//                 }
//               });
//         },
//       ),
//     );
//   }
// }

// class ProfileEditPage extends StatefulWidget {
//   const ProfileEditPage({Key? key}) : super(key: key);

//   @override
//   _ProfileEditPageState createState() => _ProfileEditPageState();
// }

// class _ProfileEditPageState extends State<ProfileEditPage> {
//   @override
//   Widget build(BuildContext context) {
//     // final _userModel = Provider.of<UserModel?>(context);
//     final _auth = Provider.of<FirebaseAuthService>(context);
//     final _db = Provider.of<FirebaseDatabaseService>(context);
//     final _firstNameController = TextEditingController();
//     final _lastNameController = TextEditingController();
//     final _phoneNumberController = TextEditingController();
//     final _emailController = TextEditingController();
//     String countryCode = "+62";

//     //Text Field for first name
//     Widget firstnameField(firstName) {
//       _firstNameController.text = firstName;
//       return TextFormField(
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
//       );
//     }

//     //Text Field for last name
//     Widget lastnameField(lastName) {
//       _lastNameController.text = lastName;
//       return TextFormField(
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
//       );
//     }

//     Widget phoneNumberField(phoneNumber) {
//       _phoneNumberController.text = phoneNumber;
//       return Container(
//         child: Row(children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               child: CountryCodePicker(
//                 onChanged: (country) {
//                   setState(() {
//                     countryCode = country.dialCode!;
//                   });
//                 },
//                 initialSelection: countryCode,
//                 showCountryOnly: false,
//                 showOnlyCountryWhenClosed: false,
//               ),
//             ),
//           ),
//           const SizedBox(
//             width: 20,
//           ),
//           Expanded(
//             flex: 2,
//             child: TextFormField(
//               autofocus: false,
//               controller: _phoneNumberController,
//               validator: (value) {
//                 //using exclamation mark (!) in front variable for telling flutter that the variable is not null
//                 //this is happen because flutter will not allow null variable as it will cause compile error
//                 if (value!.isEmpty) {
//                   return ("Please input your phone number");
//                 }
//                 if (RegExp(r"^[0]").hasMatch(value)) {
//                   return ("Don't include zero at the beginning");
//                 }
//                 if (!RegExp(r"^[0-9]{10,11}").hasMatch(value)) {
//                   return ("Please enter valid Phone Number");
//                 }
//               },
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.all(20),
//                 border: const OutlineInputBorder(),
//                 labelText: "phone number",
//                 labelStyle: TextStyle(
//                   color: secondaryColor,
//                 ),
//               ),
//             ),
//           ),
//         ]),
//       );
//     }

//     //Text Field for email
//     Widget emailField(email) {
//       _emailController.text = email;

//       return TextFormField(
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
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile Edit"),
//       ),
//       body: StreamBuilder<UserModel?>(
//         stream: _auth.user,
//         builder: (context, snapshot) {
//           final _userModel = snapshot.data;
//           return FutureBuilder<DocumentSnapshot?>(
//               future: _db.getUserData(_userModel?.uid),
//               builder: (BuildContext context,
//                   AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
//                 if (docSnapshot.hasData) {
//                   return Center(
//                     child: SingleChildScrollView(
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                           horizontal: 40,
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             firstnameField(docSnapshot.data?['first_name']),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             lastnameField(docSnapshot.data?['last_name']),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             phoneNumberField(docSnapshot.data?['phone_number']),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             emailField(docSnapshot.data?['email']),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               width: double.infinity,
//                               height: 50,
//                               child: ElevatedButton(
//                                 child: const Text("Update Profile"),
//                                 onPressed: () async {
//                                   await _db
//                                       .updateUserCollection(_userModel?.uid, {
//                                     'first_name': _firstNameController.text,
//                                     'last_name': _lastNameController.text,
//                                     'phone_number': countryCode +
//                                         _phoneNumberController.text,
//                                     'email': _emailController.text,
//                                   });
//                                   Navigator.popAndPushNamed(
//                                       context, '/profile');
//                                 },
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 } else {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const <Widget>[CircularProgressIndicator()],
//                     ),
//                   );
//                 }
//               });
//         },
//       ),
//     );
//   }
// }
