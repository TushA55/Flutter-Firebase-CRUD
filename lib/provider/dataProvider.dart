import 'package:firestore_crud/backend/services.dart';
import 'package:firestore_crud/models/studentModel.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class DataProvider with ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();
  String _studentName;
  int _studentAge;
  String _studentReg;
  String _studentGender;
  String _id;

  String get studentName => _studentName;
  int get studentAge => _studentAge;
  String get studentReg => _studentReg;
  String get studentGender => _studentGender;
  String get id => _id;
  Stream<List<StudentModel>> get allData => firestoreService.getStudents();

  set changeName(String studentName) {
    _studentName = studentName;
    notifyListeners();
  }

  set changeAge(int studentAge) {
    _studentAge = studentAge;
    notifyListeners();
  }

  set changeReg(String studentReg) {
    _studentReg = studentReg;
    notifyListeners();
  }

  set changeGender(String studentGender) {
    _studentGender = studentGender;
    notifyListeners();
  }

  // Functions
  loadAll(StudentModel studentModel) {
    if (studentModel != null) {
      _id = studentModel.id;
      _studentName = studentModel.studentName;
      _studentAge = studentModel.studentAge;
      _studentReg = studentModel.studentReg;
      _studentGender = studentModel.studentGender;
    } else {
      _id = null;
    }
  }

  saveData() {
    if (_id == null) {
      var uuid = Uuid();
      var newObj = StudentModel(
          studentName: _studentName,
          studentAge: _studentAge,
          studentReg: _studentReg,
          studentGender: _studentGender,
          id: uuid.v1());
      firestoreService.setData(newObj);
    } else {
      var updateObj = StudentModel(
          studentName: _studentName,
          studentAge: _studentAge,
          studentReg: _studentReg,
          studentGender: _studentGender,
          id: _id);
      firestoreService.setData(updateObj);
    }
  }

  deleteData(String id) {
    firestoreService.deleteData(id);
  }
}
