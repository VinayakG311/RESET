import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reset/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../../Models/Database.dart';
import '../../ProfessionalMyApp.dart';
class LoginProfessional extends StatefulWidget {
  static const String id ="login_screen_professional";
  @override
  _LoginProfessionalState createState() => _LoginProfessionalState();
}

class _LoginProfessionalState extends State<LoginProfessional> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    email=value;
                  },
                  decoration: kTextfieldDecoration.copyWith(hintText: "Enter your email")
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    password=value;
                  },
                  decoration: kTextfieldDecoration.copyWith(hintText:"Enter your password")
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, "login",()async {
                setState(() {
                  showspinner=true;
                });

                try{
                  final user=await _auth.signInWithEmailAndPassword(email: email, password: password);
                  if(user!=null){
                    String uid = user.user!.uid;
                    DocumentSnapshot userdata = await FirebaseFirestore.instance.collection('Professional').doc(uid).get();

                    ProfessionalModel newUser = ProfessionalModel.fromMap(userdata.data() as Map<String,dynamic>);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfessionalMyApp(userModel: newUser,firebaseUser: user.user!,)));

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


