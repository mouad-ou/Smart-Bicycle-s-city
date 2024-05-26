import 'package:bicycle_renting/models/bicycle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteDataService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addbicycle(Bicycle bicycle) async {
    DocumentReference documentReference = db.collection('bicycles').doc();

    documentReference.set(bicycle.toJson()).whenComplete(() {
      return "Successfully added to the database";
    }).catchError((e) {
      return e;
    });
    return '';
  }

  Stream<List<Bicycle>> getbicyclesList(String orderBy) {
    Query<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('bicycles');
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((e) {
        Map<String, dynamic> data = e.data();
        data['id'] = e.id;
        return Bicycle.fromJson(data);
      }).toList();
    });
  }

  Future<String> update(Bicycle bicycle) async {
    DocumentReference documentReferencer = db.collection('bicycles').doc(bicycle.id);
    documentReferencer.update(bicycle.toJson()).whenComplete(() {
      return "Sucessfully added to the database";
    }).catchError((e) {
      return e;
    });
    return '';
  }

  Future<String> delete(Bicycle bicycle) async {
    DocumentReference documentReferencer = db.collection('bicycles').doc(bicycle.id);
    documentReferencer.delete().whenComplete(() {
      return "Sucessfully deleted from database";
    }).catchError((e) {
      return e;
    });
    return '';
  }
}
