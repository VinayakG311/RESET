import 'package:reset/constants.dart';
import 'package:reset/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../mainscreen.dart';
class LoginScreen extends StatefulWidget {
  static const String id ="lpgin_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth=FirebaseAuth.instance;
  bool showspinner=false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'login',
                  child: Container(

                    child: Image.asset('login.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  email=value;
                },
                decoration: kTextfieldDecoration.copyWith(hintText: "Enter your email")
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password=value;
                },
                decoration: kTextfieldDecoration.copyWith(hintText:"Enter your password")
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, "login",()async {
                setState(() {
                  showspinner=true;
                });
                try{
                final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                if(user!=null){
                  Navigator.pushNamed(context,MyApp.id);
                }
                setState(() {
                  showspinner=false;
                });}
                catch(e){
                  print(e);
                }
              },Colors.white
              )
              ,
            ],
          ),
        ),
      ),
    );
  }
}
