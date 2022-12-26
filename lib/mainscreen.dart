import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/Professional/LoginProfessional.dart';
import 'package:reset/Professional/RegisterProfessional.dart';
import 'package:reset/Professional/WelcomeProfessional.dart';
import 'package:reset/SelectUser.dart';
import 'package:reset/WelcomeScreen.dart';
import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import 'package:reset/screens/CreateProfile.dart';
import 'package:reset/screens/ChatwithProffesional.dart';
import 'package:reset/screens/Profile%20screen.dart';
import 'Models/Database.dart';
import 'pag1-method2.dart';


class MyApp extends StatelessWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  MyApp({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
  static const String id="Main_Screen";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme:const AppBarTheme(
          backgroundColor: Color(0xffffffff),
          elevation: 0.0,
        ),
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
      home:MyHomePage(title: "RESET", userModel: userModel,firebaseuser: firebaseUser,) ,
      routes: {
        WelcomeScreen.id : (context)=>WelcomeScreen(),
        LoginScreen.id :(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        ProfileSetup.id:(context)=>ProfileSetup(firebaseUser: firebaseUser, userModel: userModel!,),
        ProfileScreen.id:(context)=>ProfileScreen(firebaseUser: firebaseUser,userModel: userModel,),
        ChatWithProffesional.id:(context)=>ChatWithProffesional(firebaseUser: firebaseUser,userModel: userModel,),
        SelectUserScreen.id:(context)=>SelectUserScreen(),
        LoginProfessional.id:(context)=>LoginProfessional(),
        RegisterProfessional.id:(context)=>RegisterProfessional(),
        ProfessionalWelcome.id:(context)=>ProfessionalWelcome(),

      },


    );
  }
}

