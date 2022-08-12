import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:reset/drawer.dart';
import 'package:reset/screens/Calender.dart';
import 'package:reset/screens/HomePage.dart';
import 'package:reset/screens/book.dart';
import 'package:reset/screens/call.dart';
import 'package:reset/screens/meditation.dart';

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage2> {
  int index=2;
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
