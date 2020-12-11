class StudentModel {
  final String studentName;
  final int studentAge;
  final String studentReg;
  final String studentGender;
  final String id;

  StudentModel(
      {this.studentName,
      this.studentAge,
      this.studentReg,
      this.studentGender,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'studentName': this.studentName,
      'studentAge': this.studentAge,
      'studentReg': this.studentReg,
      'studentGender': this.studentGender,
      'id': this.id,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> data) {
    return StudentModel(
      studentName: data['studentName'],
      studentAge: data['studentAge'],
      studentReg: data['studentReg'],
      studentGender: data['studentGender'],
      id: data['id'],
    );
  }
}
