import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:reset/Professional/ProfessionalScreens/Earnings%20Screen/HistoryEarning.dart';
import 'package:reset/Professional/ProfessionalScreens/Earnings%20Screen/HistoryRating.dart';

import '../../../Models/Database.dart';


class EarningAndStats extends StatefulWidget {
  EarningAndStats({Key? key, required this.model, this.firebaseUser}) : super(key: key);
  final ProfessionalModel model;
  final User? firebaseUser;

  @override
  _EarningAndStatsState createState() => _EarningAndStatsState();
}

class _EarningAndStatsState extends State<EarningAndStats> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 400,
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Earnings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.model.Earnings.toString()+'\$',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 35),),
                      ),

                    ],

                  ),

                ),
              ),
            ),
          ),
          OutlinedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HistoryEarning(model: widget.model,firebaseUser: widget.firebaseUser,)));
          //  controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.easeIn);
            
          }, child: Text("Check Earnings history",style: TextStyle(color: Colors.black),)),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: 400,
              height: 150,
              child: Card(
                shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rating",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                      RatingBarIndicator(
                          rating: (widget.model.rating!).toDouble(),
                          itemBuilder: (BuildContext context, int index) {
                            return Icon(Icons.star,color: Colors.amber,);
                          }),

                    ],

                  ),

                ),
              ),
            ),
          ),
          OutlinedButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HistoryRating(model: widget.model,firebaseUser: widget.firebaseUser,)));
          }, child: Text("Check Ratings history",style: TextStyle(color: Colors.black),)),

          // Card(
          //   key: key,
          //   child: Text("hi"),
          // )


        ],

      ),
    );
  }
}
