import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_crud/models/studentModel.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  // Upsert
  Future<void> setData(StudentModel studentModel) {
    var options = SetOptions(merge: true);
    return _db
        .collection('studentData')
        .doc(studentModel.id)
        .set(studentModel.toMap(), options);
  }

  // Read
  Stream<List<StudentModel>> getStudents() {
    return _db.collection('studentData').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => StudentModel.fromMap(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  // Delete
  Future<void> deleteData(String id) {
    return _db.collection('studentData').doc(id).delete();
  }
}
