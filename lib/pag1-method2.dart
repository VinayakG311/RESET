import 'package:flutter/material.dart';

import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:reset/drawer.dart';
import 'package:reset/flutter-icons-52b690ff/my_flutter_app_icons.dart';
import 'package:reset/screens/Calender.dart';
import 'package:reset/screens/HomePage.dart';
import 'package:reset/screens/book.dart';
import 'package:reset/screens/call.dart';
import 'package:reset/screens/meditation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected=2;
  final screens=[
    Call(),
    Calender(),
    HomePage(),
    meditation(),
    book()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: screens[selected],
      drawer: hamburger(),
      bottomNavigationBar:FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: const Color(0xFFF9A826),
          selectedItemBorderColor: Colors.yellow,
          selectedItemBackgroundColor: const Color(0xFFFFE985),
          selectedItemIconColor: Colors.black,
          selectedItemLabelColor: Colors.black,
          unselectedItemIconColor: Colors.black,

        ),


        items:  <FFNavigationBarItem> [

          FFNavigationBarItem(iconData:(Icons.call),label: "",),
          FFNavigationBarItem(iconData:(Icons.calendar_today),label: ""),
          FFNavigationBarItem(iconData:(Icons.home),label: ""),
          FFNavigationBarItem(iconData:MyFlutterApp.meditation,label: ""),
          FFNavigationBarItem(iconData:(Icons.book),label: ""),
          //   BottomNav
        ],
        selectedIndex: selected,

        onSelectTab: (index) {
    setState(() {
      this.selected=index;
    });
    },
        //showSelectedLabels: false,
        // showUnselectedLabels: false
      ),);
  }
}
