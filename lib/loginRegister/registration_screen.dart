import 'package:firebase_auth/firebase_auth.dart';
import 'package:reset/constants.dart';
import 'package:reset/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../mainscreen.dart';
class RegistrationScreen extends StatefulWidget {
  static const String id ="registration_screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
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
                    email=value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(hintText:"Enter your email")
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(hintText: "Enter your password")
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, "register",() async{
                setState(() {
                  showSpinner=true;
                });
                try {
                  final newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if(newuser!=null){
                    Navigator.pushNamed(context, MyApp.id);
                  }
                  setState(() {
                    showSpinner=false;
                  });
                }

              catch(e){
                  print(e);
              }
      },Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
