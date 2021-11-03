import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_wallet_app/constans.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future addUserToDb(data) {
    CollectionReference users = _db.collection(Constants.dbUserCollection);
    return users.add(data);
  }
}
