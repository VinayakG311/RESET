import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ff_navigation_bar_lts/ff_navigation_bar_lts.dart';
import 'package:reset/Models/Database.dart';
import 'package:reset/components/Widgets.dart';
import 'package:reset/components/drawer.dart';
import 'package:reset/flutter-icons-52b690ff/my_flutter_app_icons.dart';

import 'User/screens/Book Screen /book.dart';
import 'User/screens/Calender Screen/Calender.dart';
import 'User/screens/Home Screen/HomePage.dart';
import 'User/screens/Meditation Screen/meditation.dart';
import 'User/screens/Profile Screen user/Profile screen.dart';
import 'User/screens/chat screen/Meet the Professional.dart';


class MyHomePage extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseuser;
  const MyHomePage({Key? key, required this.title,this.userModel,this.firebaseuser}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selected=2;

  @override
  Widget build(BuildContext context) {
    final screens=[
      MeetTheProfessional(firebaseUser: widget.firebaseuser,userModel: widget.userModel,),
      Calender(firebaseuser: widget.firebaseuser,userModel: widget.userModel,),
      HomePage(firebaseUser: widget.firebaseuser,userModel: widget.userModel,),
      meditation(firebaseUser: widget.firebaseuser,userModel: widget.userModel,),
      book(firebaseUser: widget.firebaseuser,userModel: widget.userModel,)
    ];
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
           ProfileIcon(
               context,(){Navigator.of(context)
               .push(MaterialPageRoute(
               builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseuser,) ));
           })
        ],
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: screens[selected],
      drawer: const hamburger(),
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
      selected=index;
    });
    },
        //showSelectedLabels: false,
        // showUnselectedLabels: false
      ),);
  }
}
