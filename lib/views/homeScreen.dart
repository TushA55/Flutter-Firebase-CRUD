import 'package:firestore_crud/models/studentModel.dart';
import 'package:firestore_crud/provider/dataProvider.dart';
import 'package:firestore_crud/views/addData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AddData(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<List<StudentModel>>(
        stream: dataProvider.allData,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.length == 0) {
            return Center(child: Text('No Data Avaliable'));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        snapshot.data[index].studentAge.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ),
                  title: Text(snapshot.data[index].studentName),
                  subtitle: Text(snapshot.data[index].studentReg),
                  trailing: Icon(Icons.edit),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddData(
                        studentModel: snapshot.data[index],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          print(snapshot.error);
          return Center(
            child: Text('Error Occred'),
          );
        },
      ),
    );
  }
}
