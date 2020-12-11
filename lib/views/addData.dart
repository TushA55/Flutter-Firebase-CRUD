import 'package:firestore_crud/models/studentModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

class AddData extends StatefulWidget {
  final StudentModel studentModel;

  const AddData({Key key, this.studentModel}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final _name = TextEditingController();
  final _age = TextEditingController();
  final _reg = TextEditingController();
  final _gender = TextEditingController();

  @override
  void initState() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    if (widget.studentModel != null) {
      _name.text = widget.studentModel.studentName;
      _age.text = widget.studentModel.studentAge.toString();
      _reg.text = widget.studentModel.studentReg;
      _gender.text = widget.studentModel.studentGender;
      dataProvider.loadAll(widget.studentModel);
    } else {
      dataProvider.loadAll(null);
    }
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _reg.dispose();
    _gender.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Add Data'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              TextField(
                cursorColor: Theme.of(context).accentColor,
                onChanged: (String value) => dataProvider.changeName = value,
                controller: _name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Name',
                ),
              ),
              TextField(
                cursorColor: Theme.of(context).accentColor,
                onChanged: (String value) =>
                    dataProvider.changeAge = int.parse(value),
                controller: _age,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Age',
                ),
              ),
              TextField(
                cursorColor: Theme.of(context).accentColor,
                onChanged: (String value) => dataProvider.changeReg = value,
                controller: _reg,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Registration Number',
                ),
              ),
              TextField(
                cursorColor: Theme.of(context).accentColor,
                onChanged: (String value) => dataProvider.changeGender = value,
                controller: _gender,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Gender',
                ),
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text(
                  widget.studentModel == null ? 'Add' : 'Update',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (int.tryParse(_age.text) == null) {
                    final snackBar =
                        SnackBar(content: Text('Please Enter a valid Age!'));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  } else if (_name.text != '' &&
                      _age.text != '' &&
                      _reg.text != '' &&
                      _gender.text != '') {
                    dataProvider.saveData();
                    Navigator.pop(context);
                  } else {
                    final snackBar =
                        SnackBar(content: Text('Please Fill All Fields !'));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                },
              ),
              widget.studentModel != null
                  ? RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        dataProvider.deleteData(widget.studentModel.id);
                        Navigator.pop(context);
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
