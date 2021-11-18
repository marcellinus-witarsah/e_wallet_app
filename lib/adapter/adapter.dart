import 'package:cloud_firestore/cloud_firestore.dart';

class Adapter {
  static Future getSpecificDataFromDb(dbCollection) async {
    CollectionReference dataCollection = dbCollection;
    try {
      return await dataCollection.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              Map<String, dynamic> data =
                  element.data() as Map<String, dynamic>;
              print("Full name ${data['first_name']} ${data['last_name']}");
            })
          });
    } catch (e) {
      return e.toString();
    }
  }
}
