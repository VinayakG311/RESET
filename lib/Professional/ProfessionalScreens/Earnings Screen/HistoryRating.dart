import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Models/Database.dart';

class HistoryRating extends StatefulWidget {
  const HistoryRating({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;
  @override
  State<HistoryRating> createState() => _HistoryRatingState();
}

class _HistoryRatingState extends State<HistoryRating> {
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
