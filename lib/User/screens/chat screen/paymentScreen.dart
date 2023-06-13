import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../Models/Database.dart';
import '../../../components/Widgets.dart';
import '../../../pag1-method2.dart';
import '../Profile Screen user/Profile screen.dart';
import 'BookingConfirm.dart';
class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, this.model, this.firebaseUser, this.userModel, required this.appointment}) : super(key: key);
  final ProfessionalModel? model;
  final User? firebaseUser;
  final UserModel? userModel;
  final Appointment appointment;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  CardEditController cardEditController = CardEditController();
  @override
  Widget build(BuildContext context) {
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
    elevation: 0,),
      body: Padding(

        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Payment",style: TextStyle(fontSize: 24),),
            SizedBox(height: 20,),
            CardFormField(controller: CardFormEditController(),),
            ElevatedButton(onPressed: () async {
              widget.appointment.Patient = widget.userModel?.email;
              widget.appointment.isbooked=true;

              await FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("appointments").doc(widget.appointment.uid).set(widget.appointment.toMap());
              await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("appointments").doc(widget.appointment.uid).set(widget.appointment.toMap());
              await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(widget.appointment.Day!).doc(widget.appointment.uid).set(widget.appointment.toMap());
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ConfirmBooking(userModel: widget.userModel,firebaseUser: widget.firebaseUser,model: widget.model,appointment: widget.appointment,)));

            }, child: Text("Pay",style: TextStyle(fontSize: 14),),
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
                padding: EdgeInsets.only(left: 175,right: 190),
                alignment: Alignment.center
            ),)
          ],
        ),
      ),
    );
  }
}


// newAppoint.Patient = widget.userModel?.email;
// newAppoint.isbooked=true;
// // print(newAppoint.uid);
// //print(newAppoint.Patient);
// //  await FirebaseFirestore.instance.collection("collectionPath")
// await FirebaseFirestore.instance.collection("users").doc(widget.userModel?.uid).collection("appointments").doc(widget.appointment[i].uid).set(newAppoint.toMap());
// await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection("appointments").doc(widget.appointment[i].uid).set(newAppoint.toMap());
//
// await FirebaseFirestore.instance.collection("Professional").doc(widget.model?.uid).collection(newAppoint.Day!).doc(newAppoint.uid).set(newAppoint.toMap());
