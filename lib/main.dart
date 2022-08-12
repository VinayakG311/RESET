import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reset/WelcomeScreen.dart';
import 'package:reset/chat_screen.dart';
import 'package:reset/loginRegister/login_screen.dart';
import 'package:reset/loginRegister/registration_screen.dart';
import 'mainscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const RESET());
}

class RESET extends StatelessWidget {
  const RESET({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: { WelcomeScreen.id:(context)=>WelcomeScreen(),
        LoginScreen.id:(context)=>LoginScreen(),
        RegistrationScreen.id:(context)=>RegistrationScreen(),
      MyApp.id:(context)=>const MyApp(),
      ChatScreen.id:(context)=>ChatScreen(),
      },

    );
  }
}
