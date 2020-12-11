import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_crud/provider/dataProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Views
import 'views/homeScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(
    () => print(
      "Connection Complete",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.ralewayTextTheme(),
          accentColor: Colors.pinkAccent,
          primaryColor: Colors.black,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
