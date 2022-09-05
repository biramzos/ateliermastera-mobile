import 'package:ateliermastera/APIs/UserService.dart';
import 'package:ateliermastera/SQL/SavedUserService.dart';
import 'package:flutter/material.dart';
import 'Pages/LoginPage/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ателье МастерА',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      locale: Locale('ru'),
    );
  }
}
