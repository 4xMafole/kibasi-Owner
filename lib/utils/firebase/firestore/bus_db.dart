import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kibasi/content/assets/models/bus.dart';
import 'package:kibasi/utils/firebase/firestore/database.dart';

class BusDatabase {
  static const String BUSES = "BUSES";

  String userUid;
  CollectionReference companyCollection;

  BusDatabase(
    this.userUid,
    this.companyCollection,
  );

  Future<DocumentReference?> addBus({
    required Bus busData,
  }) async {
    DocumentReference documentReference = companyCollection
        .doc(userUid)
        .collection("BUSES")
        .doc(busData.plateNumber);

    await documentReference
        .set(busData.toMap())
        .whenComplete(() => print("Bus added to the database"))
        .catchError((e) => print(e));

    return documentReference;
  }

  Stream<QuerySnapshot> readBus() {
    CollectionReference busCollection =
        companyCollection.doc(userUid).collection("BUSES");

    return busCollection.snapshots();
  }

  Future<void> updateBus({
    required String plateNumber,
    required String busName,
    required String documentID,
  }) async {
    DocumentReference documentReference =
        companyCollection.doc(userUid).collection("BUSES").doc(documentID);

    Map<String, dynamic> data = <String, dynamic>{
      "plate_number": plateNumber,
      "name": busName,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("Bus updated in the database"))
        .catchError((e) => print(e));
  }

  Future<void> deleteBus({required String documentID}) async {
    DocumentReference documentReference =
        companyCollection.doc(userUid).collection("BUSES").doc(documentID);

    await documentReference
        .delete()
        .whenComplete(() => print('Bus deleted from the database'))
        .catchError((e) => print(e));
  }
}
