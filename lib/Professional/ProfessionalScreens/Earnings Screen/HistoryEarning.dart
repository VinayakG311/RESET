import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Models/Database.dart';

class HistoryEarning extends StatefulWidget {
  const HistoryEarning({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;

  @override
  State<HistoryEarning> createState() => _HistoryEarningState();
}

class _HistoryEarningState extends State<HistoryEarning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black,),
      ),
      body: Text("hi"),
    );
  }
}
