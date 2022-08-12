import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:reset/components/RoundedButtons.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id ="welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
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
            RoundedButton(Colors.black, "login",(){Navigator.pushNamed(context, LoginScreen.id);},Colors.white),
            RoundedButton(Colors.white, "Registration",(){Navigator.pushNamed(context, RegistrationScreen.id);},Colors.black),

          ],
        ),
      ),
    );
  }
}
