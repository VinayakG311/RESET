import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reset/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Models/Database.dart';
import '../User/screens/Profile Screen user/CreateProfile.dart';
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
                    email=value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(hintText:"Enter your email")
              ),
              const SizedBox(
                height: 8.0,
              ),

              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                  password=value;
                  //Do something with the user input.
                },
                decoration: kTextfieldDecoration.copyWith(hintText: "Enter your password")
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(Colors.lightBlueAccent, "register",() async{
                setState(() {
                  showSpinner=true;
                });
                try {
                  final newuser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  String uid = newuser.user!.uid;
                  UserModel user = UserModel(uid: uid,email: email,firstname: '');
                  await FirebaseFirestore.instance.collection('users').doc(uid).set(
                      user.toMap()).then((value){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ProfileSetup(firebaseUser:newuser.user ,userModel:user ,)));
                  });
                  setState(() {
                    showSpinner=false;
                  });
                }

                catch(e){
                  print(e);
                  setState(() {
                    showSpinner=false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    content: Text(e.toString(),style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.red,
                  ));
                }
      },Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
