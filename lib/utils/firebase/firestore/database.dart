import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kibasi/content/assets/models/bus.dart';
import 'package:kibasi/utils/firebase/fire_auth/fire_auth.dart';
import 'package:kibasi/utils/firebase/firestore/bus_db.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _companyCollection =
    _firestore.collection("COMPANIES");

class Database {
  static String? userUid = FireAuth.currentUser()!.uid;

  static Future<void> addOwner({
    required String ownerName,
    String? companyName,
    String? companyLicense,
    String? nationalID,
    int? phoneNumber,
  }) async {
    //Details to add owner's details
  }

  static Future<DocumentReference?> addBusDetails({
    required Bus data,
  }) {
    return BusDatabase(userUid!, _companyCollection).addBus(
      busData: data,
    );
  }

  static Stream<QuerySnapshot> readBusDetails() {
    return BusDatabase(userUid!, _companyCollection).readBus();
  }
}
