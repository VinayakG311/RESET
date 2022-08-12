import 'package:flutter/material.dart';
import 'page1.dart';
import 'pag1-method2.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String id="Main_Screen";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme:const AppBarTheme(
          backgroundColor: Color(0xffffffff),
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
      home: const MyHomePage(title: "RESET",) ,

    );
  }
}

