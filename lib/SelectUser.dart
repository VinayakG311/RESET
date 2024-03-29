import 'package:firebase_auth/firebase_auth.dart';
import 'package:reset/Professional/WelcomeProfessional.dart';
import 'package:reset/WelcomeScreen.dart';
import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:reset/components/RoundedButtons.dart';

import 'Models/Database.dart';

class SelectUserScreen extends StatefulWidget {
  static const String id ="welcome_screen_SelectUser";
  // final UserModel? userModel;
  // final User? firebaseUser;

  //WelcomeScreen({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  @override

  _SelectUserScreenState createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> with SingleTickerProviderStateMixin {
  late AnimationController Controller;
  late Animation animation;
  @override
  void initState(){
    super.initState();
    Controller=AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    animation=CurvedAnimation(parent: Controller, curve: Curves.decelerate);
    Controller.forward();
    Controller.addListener(() {
      setState(() {
      });
      //print(animation.value);

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                    children:[
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Image.asset('images/reset.png',width: 150,),
                      ),
                      Hero(
                        tag: 'logo',
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Image.asset('images/loginregister.png',width: 300,),

                        ),
                      )]),
                // AnimatedTextKit(
                //                 //   animatedTexts: [TypewriterAnimatedText('Flash Chat',textStyle: TextStyle(
                //                 //       fontSize: 40.0,
                //                 //       fontWeight: FontWeight.w900,
                //                 //       color: Colors.black
                //                 //   ),)],
                //                 // )
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(Colors.black, "User",(){Navigator.pushNamed(context, WelcomeScreen.id);},Colors.white),
            RoundedButton(Colors.white, "Professional",(){Navigator.pushNamed(context, ProfessionalWelcome.id);},Colors.black),

          ],
        ),
      ),
    );
  }
}
