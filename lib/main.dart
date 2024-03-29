import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reset/Professional/ProfessionalScreens/LoginRegisterProfessional/LoginProfessional.dart';
import 'package:reset/Professional/ProfessionalMyApp.dart';
import 'package:reset/Professional/ProfessionalScreens/LoginRegisterProfessional/RegisterProfessional.dart';
import 'package:reset/Professional/WelcomeProfessional.dart';
import 'package:reset/SelectUser.dart';
import 'package:reset/WelcomeScreen.dart';
import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import 'components/Helpers.dart';
import 'mainscreen.dart';
import 'package:reset/Models/Database.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
const seckey="sk_test_51NDLhwSIp9cH6CWdKeV1819kOUchby3a4GN0NwoDNojoVsLghhWg1T2PyESQczx43zJ7TQhCn0ssq1PMTvRsLB9n00AIaaBVP1";
const pkey="pk_test_51NDLhwSIp9cH6CWdM4Pl3FEBcKsriaRA0RivhnT1bwnjPdFxcm9d3PysA8R89rBB1KvLW3huLZID3pfyzm7tYIGo00CBiT98J6";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = pkey;
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  User? currentUser = FirebaseAuth.instance.currentUser;

  if(currentUser!=null){

    UserModel? thisUser = await FirebaseHelper.GetUserModelById(currentUser.uid);
    if(thisUser!=null){
      runApp(RESETLoggedin(userModel: thisUser, firebaseUser: currentUser));

    }
    else{


      ProfessionalModel? professional = await FirebaseHelperPro.GetUserModelById(currentUser.uid);
      if(professional!=null){

        runApp(RESETLoggedinProfessional(userModel: professional, firebaseUser: currentUser));

      }
      else{

      runApp(const RESET());
      }

    }

  }
  else{
  runApp(const RESET());
  }
}

class RESET extends StatelessWidget {
  const RESET({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: SelectUserScreen.id,
      routes: {
        SelectUserScreen.id:(context)=>SelectUserScreen(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
      MyApp.id:(context)=>MyApp(),
     // ChatScreen.id:(context)=>ChatScreen(),
        ProfessionalWelcome.id:(context)=>ProfessionalWelcome(),
        RegisterProfessional.id:(context)=>RegisterProfessional(),
        LoginProfessional.id:(context)=>LoginProfessional(),

      },

    );
  }
}

class RESETLoggedin extends StatelessWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  RESETLoggedin({Key? key,required this.userModel,required this.firebaseUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: MyApp.id,
      routes: { WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
        MyApp.id:(context)=>MyApp(firebaseUser: firebaseUser,userModel: userModel,),
        ProfessionalWelcome.id:(context)=>ProfessionalWelcome(),
        RegisterProfessional.id:(context)=>RegisterProfessional(),
        LoginProfessional.id:(context)=>LoginProfessional(),

        // ChatScreen.id:(context)=>ChatScreen(firebaseUser:firebaseUser ,userModel:userModel ,),
      },

    );
  }
}

class RESETLoggedinProfessional extends StatelessWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  const RESETLoggedinProfessional({Key? key,required this.userModel,required this.firebaseUser}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: ProfessionalMyApp.id,
      routes: {
        ProfessionalMyApp.id:(context)=>ProfessionalMyApp(userModel: userModel,firebaseUser: firebaseUser,),
        ProfessionalWelcome.id:(context)=>ProfessionalWelcome(),
        LoginProfessional.id:(context)=>LoginProfessional(),
        RegisterProfessional.id:(context)=>RegisterProfessional(),
        WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),

      },

    );
  }
}