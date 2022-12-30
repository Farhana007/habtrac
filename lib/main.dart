import 'package:flutter/material.dart';
import 'page/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main () async{
  //initialize hive
  await Hive.initFlutter();

  //open a box

  await Hive.openBox("Habit_DataBase");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.deepOrange),
    );
  }
}


