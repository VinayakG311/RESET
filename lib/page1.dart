import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:reset/components/drawer.dart';

import 'Models/Database.dart';
import 'User/screens/Book Screen /book.dart';
import 'User/screens/Calender Screen/Calender.dart';
import 'User/screens/Home Screen/HomePage.dart';
import 'User/screens/Meditation Screen/meditation.dart';
import 'User/screens/call.dart';

class MyHomePage2 extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;

  const MyHomePage2({Key? key, required this.title,this.firebaseUser,this.userModel}) : super(key: key);
  final String title;
  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  int index=2;


  @override
  Widget build(BuildContext context) {

    final screens=[
      Call(userModel:widget.userModel ,firebaseUser: widget.firebaseUser,),
      Calender(),
      HomePage(),
      meditation(),
      book()
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
      ),

      body: screens[index],
      drawer: hamburger(),

      bottomNavigationBar:CurvedNavigationBar(

        color: const Color(0xFFF9A826),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: const Color(0xFFFFE985),
        index: index,
        items: const <Widget> [
          Icon(Icons.call,color: Colors.black,),
          Icon(Icons.calendar_today,color: Colors.black),
          Icon(Icons.home,color: Colors.black,),
          ImageIcon(AssetImage("images/meditation.png"),color: Colors.black,),
          Icon(Icons.book,color: Colors.black,),


          //   BottomNav
        ],
        onTap: (index){
          setState(() {
            this.index=index;
          });
        },
        //showSelectedLabels: false,
        // showUnselectedLabels: false
      ),);
  }
}
