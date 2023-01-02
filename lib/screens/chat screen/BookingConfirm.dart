import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Models/Database.dart';
import '../../components/Widgets.dart';
import '../../pag1-method2.dart';
import '../Profile screen.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking({Key? key, this.model, this.firebaseUser, this.userModel, required this.appointment}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;
  final Appointment appointment;

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  @override
  Widget build(BuildContext context) {
    ProfessionalModel professionalModel = widget.model!;
    UserModel userModel1 = widget.userModel!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          ProfileIcon(
              context,(){Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context)=> ProfileScreen(userModel: widget.userModel,firebaseUser: widget.firebaseUser,) ));
          })
        ],
        title: InkWell(
          child: const Text("Talk"),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
          },),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 50.0,fontWeight: FontWeight.bold),
        leading: const BackButton(color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              Text("Your Booking Has Been Confirmed",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children: [
                    Text("Name of Doctor: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                    Text(professionalModel.firstname!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children: [
                    Text("Name of Patient: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                    Text(userModel1.firstname!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child:Row(
                  children: [
                    Text("Mode: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                    Text(widget.appointment.type!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                  ],
                ) ,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child:Row(
                  children: [
                    Text("Cost: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                    widget.appointment.type=="Call"?Text(professionalModel.call.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)):Text(professionalModel.chat.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal)),
                  ],
                ) ,
              ),
              RoundedButton(Colors.white, "Go to Home Screen", () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage(userModel: widget.userModel,firebaseuser: widget.firebaseUser, title: 'RESET',)));
              }, Colors.black)

            ],
          ),
        ),
      ),

    );
  }
}
