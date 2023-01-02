

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/Database.dart';

class CreatePRof extends StatefulWidget {
  final ProfessionalModel? userModel;
  final User? firebaseUser;
  const CreatePRof({Key? key, this.userModel, this.firebaseUser}) : super(key: key);
  @override
  State<CreatePRof> createState() => _CreatePRofState();
}

class _CreatePRofState extends State<CreatePRof> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: const BackButton(color: Colors.black,)),
      body: Text("Create new"),
    );
  }
}
