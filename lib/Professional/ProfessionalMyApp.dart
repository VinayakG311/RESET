import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reset/Professional/ProfessionalScreens/LoginRegisterProfessional/LoginProfessional.dart';
import 'package:reset/Professional/ProfessionalScreens/Community%20Screen/Community.dart';
import 'package:reset/Professional/ProfessionalScreens/Profile%20Professional/ProfileScreenProfessional.dart';
import 'package:reset/Professional/WelcomeProfessional.dart';
import 'package:reset/SelectUser.dart';
import 'package:reset/WelcomeScreen.dart';
import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import '../Models/Database.dart';
import 'ProfessionalScreens/Chat Screen/ChatWithUser.dart';
import 'ProfessionalHomePage.dart';
import 'ProfessionalScreens/Profile Professional/ProfessionalProfileSetup.dart';
import 'ProfessionalScreens/LoginRegisterProfessional/RegisterProfessional.dart';


class ProfessionalMyApp extends StatelessWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  ProfessionalMyApp({Key? key,this.userModel,this.firebaseUser}) : super(key: key);
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
      home:ProfessionalHomePage(title: "RESET", userModel: userModel,firebaseuser: firebaseUser,) ,
      routes: {
        ProfessionalWelcome.id : (context)=>ProfessionalWelcome(),
        LoginProfessional.id :(context)=>LoginProfessional(),
        RegisterProfessional.id:(context)=>RegisterProfessional(),
        ProfileSetupProfessional.id:(context)=>ProfileSetupProfessional(firebaseUser: firebaseUser, userModel: userModel!,),
        ProfessionalProfileScreen.id:(context)=>ProfessionalProfileScreen(firebaseUser: firebaseUser,userModel: userModel,),
       // ChatWithUser.id:(context)=>ChatWithUser(firebaseUser: firebaseUser,userModel: userModel,)
        SelectUserScreen.id:(context)=>SelectUserScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
      },


    );
  }
}

