import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:e_wallet_app/constants.dart';
import 'package:e_wallet_app/controller/database_controller.dart';
import 'package:e_wallet_app/controller/user_controller.dart';
import 'package:e_wallet_app/models/user_model.dart';
import 'package:e_wallet_app/view/topup_screen.dart';
import 'package:e_wallet_app/view/transfer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeScreen(),
    );
  }
}

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  final UserController _userController = Get.put(UserController());
  final DatabaseController _databaseController = Get.put(DatabaseController());
  final CurrencyFormatter _currencyFormatter = CurrencyFormatter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<UserModel?>(
        stream: _userController.user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder<DocumentSnapshot?>(
              future: _databaseController.getUserData(snapshot.data?.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot?> docSnapshot) {
                if (docSnapshot.hasData) {
                  String balance = _currencyFormatter.format(
                      docSnapshot.data?['balance'], CurrencyFormatter.idr);
                  return Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage('asset/images/logo.png'),
                                  )),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "eWallet",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'ubuntu',
                                      fontSize: 25),
                                )
                              ],
                            )
                          ],
                        ),
                        const Text(
                          "Account Overview",
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'avenir'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Color(0xfff1f3f6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    balance,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Current Balance",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.toNamed('/topup');
                                  },
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: const CircleBorder(),
                                      primary: const Color(0xffffac30)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Send Money",
                              style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'avenir'),
                            ),
                            InkWell(
                              onTap: () async {
                                await _userController.scanQRCode();
                              },
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'asset/images/scanqr.png'))),
                              ),
                            )
                          ],
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.only(right: 20),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffffac30),
                                ),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        primary: const Color(0xffffac30)),
                                  ),
                                ),
                              ),
                              avatarWidget("avatar1", "Mike"),
                              avatarWidget("avatar2", "Joseph"),
                              avatarWidget("avatar3", "Ashley"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const <Widget>[
                                Text(
                                  'Services',
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'avenir'),
                                ),
                                Icon(Icons.dialpad),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.count(
                            padding: EdgeInsets.all(0),
                            shrinkWrap: true,
                            crossAxisCount: 4,
                            childAspectRatio: 0.7,
                            children: [
                              serviceWidget(
                                  "sendMoney", "Send\nMoney", "/transfer"),
                              serviceWidget("receiveMoney", "Receive\nMoney",
                                  "/homepage"),
                              serviceWidget(
                                  "phone", "Mobile\nRecharge", "/homepage"),
                              serviceWidget("electricity", "Electricity\nBill",
                                  "/homepage"),
                              serviceWidget(
                                  "tag", "Cashback\nOffer", "/homepage"),
                              serviceWidget(
                                  "movie", "Movie\nTicket", "/homepage"),
                              serviceWidget(
                                  "flight", "Flight\nTicket", "/homepage"),
                              serviceWidget("more", "More\n", "/homepage"),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
                return costumizedCircularIndicator;
              },
            );
          }
          return costumizedCircularIndicator;
        },
      ),
    );
  }

  Column serviceWidget(String img, String name, PageRoute) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              Get.toNamed(PageRoute);
            },
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Color(0xfff1f3f6),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('asset/images/$img.png'))),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: const TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 150,
      width: 120,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xfff1f3f6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('asset/images/$img.png'),
                    fit: BoxFit.contain),
                border: Border.all(color: Colors.black, width: 2)),
          ),
          Text(
            name,
            style: const TextStyle(
                fontSize: 16,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
